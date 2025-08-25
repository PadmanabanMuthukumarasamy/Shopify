class Order < ApplicationRecord
  belongs_to :store
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  validates :status, inclusion: { in: %w[pending paid cancelled] }
  after_commit :finalize_callbacks, on: :create

  private
  def finalize_callbacks
    ::InventoryReductionWorker.reduce_stocks_async(id)
    ::OrderConfirmationWorker.order_mailer_async(id)
  end
end
