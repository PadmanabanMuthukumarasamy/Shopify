# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    #binding.break
    products = Product.for_current_tenant.page(params[:page]).per(10)
    if products.blank?
      raise TenantNotFoundError.new("Store with given store_id is not found")
    end
    render json: {
      page: products.current_page,
      total_pages: products.total_pages,
      count: products.size,
      products: products.select(:id, :name, :product_code, :price, :stock)
    }
  end
end
