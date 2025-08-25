class Cart < ApplicationRecord
  belongs_to :store
  belongs_to :customer
  has_many :cart_items, dependent: :destroy

  validates :status, inclusion: { in: %w[open checked_out] }

  def total_price
    cart_items.sum { |ci| ci.quantity * ci.product.price }
  end


end
