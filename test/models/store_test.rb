# frozen_string_literal: true

require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  def setup
    @store = stores(:aldos_store)
    @shoe = shoes(:running_shoe)
    @inventory_item = inventory_items(:aldos_running_shoes)
    @sale = @inventory_item.sales.create!(quantity_sold: 5)
  end

  test 'should be valid' do
    assert @store.valid?
  end

  test 'should require a name' do
    @store.name = nil
    assert_not @store.valid?
    assert_includes @store.errors[:name], "can't be blank"
  end

  test 'should have a unique name' do
    duplicate_store = @store.dup
    assert_not duplicate_store.valid?
    assert_includes duplicate_store.errors[:name], 'has already been taken'
  end

  test 'total_inventory_value should calculate correctly' do
    assert_equal 50 * 99.99, @store.total_inventory_value
  end

  test 'high_stock_items should return items with high stock' do
    assert_includes @store.high_stock_items, @inventory_item
  end

  test 'low_stock_items should return items with low stock' do
    @inventory_item.update!(quantity: 5)
    assert_includes @store.low_stock_items, @inventory_item
  end
end
