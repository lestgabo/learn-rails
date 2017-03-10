class UserMailer < ApplicationMailer
  default from: "do-not-reply@example.com"
  
  def contact_email(name, email, content)
    #@contact = contact
    @name = name
    @email = email
    @content = content
    mail(to: Rails.application.secrets.owner_email, from: @email, :subject => "Website Contact")
  end
end