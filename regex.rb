LOCALES = {
  en: {
    subject: "Our website is online",
    body: "Come and visit us!",
    closing: "See you soon",
    signature: "The Team"
  },
  fr: {
    subject: "Notre site est en ligne",
    body: "Venez nous rendre visite !",
    closing: "A bientot",
    signature: "L'équipe"
  },
  de: {
    subject: "Unsere Website ist jetzt online",
    body: "Komm und besuche uns!",
    closing: "Bis bald",
    signature: "Das Team"
  }
}

def valid?(email)
  # TODO: return true if the email is valid, false otherwise
  if email.match?(/^[a-zA-Z0-9]+@[a-zA-Z0-9]*(?:[\s.-])+[\w-]{2,4}$/)
    true
  else
    false
  end
end

def clean_database(emails)
  # TODO: return an array with the valid emails only
  emails.select { |email| valid?(email) }
end

def group_by_tld(emails)
  # TODO: return a Hash with emails grouped by TLD
  # group = {}
  # emails.map do |email|
  # modified_one = email.split(".").last
  # TODO: return a Hash with emails grouped by TLD
  emails.group_by { |email| email.match(/.(\w+)$/)[1] }
end

def compose_mail(email)
  # TODO: return a Hash with username, domain and tld extracted from email
  email_info = email.scan(/([a-z]*)@([a-z]*).([a-z]*)/)
  {
    username: email_info[0][0],
    domain: email_info[0][1],
    tld: email_info[0][2]
  }
end


def compose_translated_email(email)
  # email_info = email.scan(/([a-z]*)@([a-z]*).([a-z]*)/)
  language = LOCALES.key?(compose_mail(email)[:tld].to_sym) ? compose_mail(email)[:tld].to_sym : :en
  {
    username: compose_mail(email)[:username],
    domain: compose_mail(email)[:domain],
    tld: compose_mail(email)[:tld],
    subject: LOCALES[language][:subject],
    body: LOCALES[language][:body],
    closing: LOCALES[language][:closing],
    signature: LOCALES[language][:signature]
  }
end
