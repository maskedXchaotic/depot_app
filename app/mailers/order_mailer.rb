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
    @order.line_items.each do |line_item|
      line_item.product.product_images.each_with_index do |product_image, index|
        if index == 0
          attachments.inline["#{line_item.product.title}_cover_image"] = product_image.download
        else
          attachments["#{line_item.product.title}_#{index}_#{product_image.filename}"] = product_image.download
        end 
      end
    end
    I18n.with_locale(@order.user.lang) do
      mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @greeting = order

    mail to: order.email , subject: t('.subject')
  end
end
