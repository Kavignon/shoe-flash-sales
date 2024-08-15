class InventoryItem < ApplicationRecord
  belongs_to :store
  belongs_to :shoe

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  LOW_STOCK_THRESHOLD = 10

  def low_in_stock?
    quantity < LOW_STOCK_THRESHOLD
  end

  def adjust_quantity!(quantity_sold)
    update!(quantity: quantity - quantity_sold)
  end
end
