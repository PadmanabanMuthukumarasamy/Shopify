class Store < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :orders, dependent: :destroy
  validates :name, :store_id, presence: true
  validates :store_id, uniqueness: true
end
