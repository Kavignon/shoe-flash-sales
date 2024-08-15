# frozen_string_literal: true

# Model class for representing the attributes and expected behavior for a Sale in a store.
class Sale < ApplicationRecord
  belongs_to :inventory_item

  after_create :adjust_inventory

  validates :quantity_sold, presence: true, numericality: { only_integer: true, greater_than: 0 }

  private

  def adjust_inventory
    return unless quantity_sold.present? && quantity_sold.positive?

    inventory_item.adjust_quantity!(quantity_sold: quantity_sold)
  end
end
