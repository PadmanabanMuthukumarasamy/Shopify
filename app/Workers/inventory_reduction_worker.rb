# frozen_string_literal: true

class InventoryReductionWorker

  include Sidekiq::Worker

  def self.reduce_stocks_async(order_id, store_id)
    perform_async(order_id, store_id)
  end
  def perform(order_id, store_id)
    CurrentTenant.set(tenant: Store.find(store_id)) do
      order = Order.includes(order_items: :product).find(order_id)
      order.order_items.each do |oi|
        p = oi.product
        p.with_lock do
          p.update!(stock: p.stock - oi.quantity)
        end
      end
    end
  end

end
