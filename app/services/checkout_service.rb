# frozen_string_literal: true

class CheckoutService
  class Error < StandardError; end

  def initialize(cart:)
    @cart = cart
    @store = cart.store
  end

  def call!
    raise Error, "Cart is empty" if @cart.cart_items.blank?
    Order.transaction do
      validate_prices_and_stock!

      order = Order.create!(
        store: @store,
        customer: @cart.customer,
        total_price: @cart.total_price,
        status: "paid"
      )
      @cart.cart_items.includes(:product).each do |ci|
        order.order_items.create!(
          product: ci.product,
          quantity: ci.quantity,
          price: ci.product.price
        )
      end

      @cart.update!(status: "checked_out")
      order
    end
  end

  private
  def validate_prices_and_stock!
    @cart.cart_items.includes(:product).each do |ci|
      p = ci.product
      raise Error, "Insufficient stock for #{p.product_code}" if p.stock < ci.quantity
      raise Error, "Price mismatch for #{p.product_code}" if ci.product.price <= 0
    end
  end
end
