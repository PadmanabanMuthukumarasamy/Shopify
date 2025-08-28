# frozen_string_literal: true

class CartItemBlueprint < Blueprinter::Base
  identifier :id
  fields :product_id, :quantity

  field :name do |ci|
    ci.product.name
  end

  field :price do |ci|
    ci.product.price
  end

  field :total_price_of_products do |ci|
    ci.quantity * ci.product.price
  end
end
