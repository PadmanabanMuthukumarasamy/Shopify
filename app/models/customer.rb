class Customer < ApplicationRecord
  belongs_to :store
  has_many :carts
  has_many :orders
  validates :email, presence: true
end
