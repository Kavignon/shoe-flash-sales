# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :inventory_item

  after_create :adjust_inventory

  private

  def adjust_inventory
    inventory_item.adjust_quantity!(quantity_sold)
  end
end
