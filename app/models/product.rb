class Product < ApplicationRecord
  belongs_to :store
  has_many :order_items

  validates :name, :product_code, :price, :stock, presence: true
  validates :product_code, uniqueness: { scope: :store_id }

  scope :for_current_tenant, -> { where(store_id: CurrentTenant.tenant&.id) }
end
