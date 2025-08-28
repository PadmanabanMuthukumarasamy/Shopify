# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    customer = CurrentTenant.tenant.customers.find(params[:customer_id])
    cart = customer.carts.find_by!(status: "open", store: CurrentTenant.tenant)
    order = CheckoutService.new(cart: cart).call!
    render json: { order_id: order.id, total_price: order.total_price, status: order.status }, status: :created
  rescue CheckoutService::Error => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
