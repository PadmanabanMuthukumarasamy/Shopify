# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart

  def show
    render json: serialize_cart(@cart)
  end

  def add_item
    product = CurrentTenant.tenant.products.find(params[:product_id])
    qty = params[:quantity].to_i
    item = @cart.cart_items.find_or_initialize_by(product: product)
    item.quantity = (item.quantity || 0) + qty
    if item.save
      render json: serialize_cart(@cart.reload)
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def set_cart
    customer = CurrentTenant.tenant.customers.find(params[:customer_id])
    @cart = customer.carts.find_or_create_by!(store: CurrentTenant.tenant, status: "open")
  end

  def serialize_cart(cart)
    {
      id: cart.id,
      customer_id: cart.customer_id,
      total_price: cart.total_price,
      items: cart.cart_items.includes(:product).map do |ci|
        {
          id: ci.id,
          product_id: ci.product_id,
          name: ci.product.name,
          product_code: ci.product.product_code,
          price: ci.product.price,
          quantity: ci.quantity,
          total_price_of_products: ci.quantity * ci.product.price
        }
      end
    }
  end
end
