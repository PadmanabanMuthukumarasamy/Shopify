class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :quantity, numericality: { greater_than: 0 }
  validate :product_belongs_to_same_store

  def product_belongs_to_same_store
    errors.add(:product_id, "must belong to this store") if cart.store_id != product.store_id
  end
end
