class UserMailer < ApplicationMailer
  default from: 'Uday Nayak <udaynayakgkv@gmail.com>'
  # layout "mailer"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.recieved.subject
  #
  def send_consolidated_email(user)
    @user = user
    mail to: user.email, subject: 'Consolidated Account Statement', 'X-SYSTEM-PROCESS-ID': Process.pid
  end
end
