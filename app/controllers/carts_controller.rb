# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart

  def show
    render json: CartBlueprint.render(@cart)
  end

  def add_item
    product = CurrentTenant.tenant.products.find(params[:product_id])
    qty = params[:quantity].to_i
    item = @cart.cart_items.find_or_initialize_by(product: product)
    item.quantity = (item.quantity || 0) + qty
    if item.save
      render json: CartBlueprint.render(@cart)
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def set_cart
    customer = CurrentTenant.tenant.customers.find(params[:customer_id])
    @cart = customer.carts.find_or_create_by!(store: CurrentTenant.tenant, status: "open")
  end
end
