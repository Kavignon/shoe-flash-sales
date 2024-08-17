# frozen_string_literal: true

require 'test_helper'

class InventoryItemTest < ActiveSupport::TestCase
  def setup
    @aldos_running_shoes = inventory_items(:aldos_running_shoes)
  end

  test 'quantity should be an integer' do
    item = InventoryItem.new(quantity: 1.5, store: stores(:aldos_store), shoe: shoes(:running_shoe))
    assert_not item.valid?
    assert_includes item.errors[:quantity], 'must be an integer'
  end

  test 'quantity should be greater than or equal to 0' do
    item = InventoryItem.new(quantity: -1, store: stores(:aldos_store), shoe: shoes(:running_shoe))
    assert_not item.valid?
    assert_includes item.errors[:quantity], 'must be greater than or equal to 0'
  end

  test 'should belong to store' do
    assert_equal stores(:aldos_store), @aldos_running_shoes.store
  end

  test 'should belong to shoe' do
    assert_equal shoes(:running_shoe), @aldos_running_shoes.shoe
  end

  test 'low_in_stock? should return false when quantity is above threshold' do
    assert_not @aldos_running_shoes.low_stock?
  end

  test 'low_stock? should return true when quantity is below low stock threshold' do
    item = InventoryItem.new(quantity: InventoryItem::LOW_STOCK_THRESHOLD - 1, store: stores(:aldos_store), shoe: shoes(:running_shoe))
    assert item.low_stock?
  end

  test 'high_in_stock? should return false when quantity is below threshold' do
    item = InventoryItem.new(quantity: InventoryItem::HIGH_STOCK_THRESHOLD - 1, store: stores(:aldos_store), shoe: shoes(:running_shoe))
    assert_not item.high_stock?
  end

  test 'high_stock? should return true when quantity is above high stock threshold' do
    item = InventoryItem.new(quantity: InventoryItem::HIGH_STOCK_THRESHOLD + 1, store: stores(:aldos_store), shoe: shoes(:running_shoe))
    assert item.high_stock?
  end

  test 'adjust_quantity! should not allow reducing quantity below 0' do
    item = InventoryItem.new(quantity: 5, store: stores(:aldos_store), shoe: shoes(:running_shoe))
    assert_raises(ActiveRecord::RecordInvalid) do
      item.adjust_quantity!(quantity_sold: 6)
    end
  end
end
