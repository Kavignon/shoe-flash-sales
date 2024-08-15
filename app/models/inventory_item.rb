# frozen_string_literal: true

# Model class for representing a specific item in the inventory of shoes in a store.
class InventoryItem < ApplicationRecord
  belongs_to :store
  belongs_to :shoe

  has_many :sales

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  LOW_STOCK_THRESHOLD = 10
  HIGH_STOCK_THRESHOLD = 50

  def high_stock?
    quantity >= HIGH_STOCK_THRESHOLD
  end

  def low_stock?
    quantity <= LOW_STOCK_THRESHOLD
  end

  def adjust_quantity!(quantity_sold: 0)
    update!(quantity: quantity - quantity_sold)

    check_stock_status
  end

  private

  def check_stock_status
    if high_stock?
      Rails.logger.info "Inventory item #{shoe.brand_name} - #{shoe.style} is high in stock with #{quantity} items remaining."
    elsif low_stock?
      Rails.logger.info "Inventory item #{shoe.brand_name} - #{shoe.style} is low in stock with #{quantity} items remaining."
    end
  end
end
