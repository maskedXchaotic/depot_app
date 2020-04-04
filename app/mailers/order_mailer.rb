class OrderMailer < ApplicationMailer
  default from: 'Uday Nayak <udaynayakgkv@gmail.com>'
  # layout "mailer"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.recieved.subject
  #
  def received(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @greeting = order

    mail to: order.email , subject: 'Order Shipped Confirmation'
  end
end
