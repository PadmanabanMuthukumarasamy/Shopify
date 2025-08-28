# frozen_string_literal: true

class CartBlueprint < Blueprinter::Base
  identifier :id
  fields :customer_id, :total_price

  association :cart_items, blueprint: CartItemBlueprint
end
