# frozen_string_literal: true

class OrderConfirmationWorker
  include Sidekiq::Worker

  def self.order_mailer_async(order_id)
    perform_async(order_id)
  end
  def perform(order_id)
    order = Order.find(order_id)
    OrderMailer.order_confirmation(order.id).deliver_now
  end
end
