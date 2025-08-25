class OrderMailer < ApplicationMailer

  def order_confirmation(order_id)
    @order = Order.find(order_id)
    mail to: @order.customer.email, subject: "Order ##{@order.id} Confirmation"
  end
end