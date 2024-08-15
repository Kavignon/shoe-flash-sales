# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :inventory_item

  after_create :adjust_inventory

  private

  def adjust_inventory(qty_item_sold: 0)
    return unless qty_item_sold.present? && qty_item_sold.is_a?(Integer) && !qty_item_sold.negative?

    inventory_item.adjust_quantity!(quantity_sold: qty_item_sold)
  end
end
