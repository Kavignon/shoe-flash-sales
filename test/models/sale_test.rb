# frozen_string_literal: true

require 'test_helper'

class SaleTest < ActiveSupport::TestCase
  def setup
    @store = stores(:aldos_store)
    @shoe = shoes(:running_shoe)
    @inventory_item = inventory_items(:aldos_running_shoes)
    @sale = @inventory_item.sales.build(quantity_sold: 5)
  end

  test 'should be valid with valid attributes' do
    assert @sale.valid?
  end

  test 'should require a quantity_sold' do
    @sale.quantity_sold = nil
    assert_not @sale.valid?
    assert_includes @sale.errors[:quantity_sold], "can't be blank"
  end

  test 'quantity_sold should be a positive integer' do
    @sale.quantity_sold = -5
    assert_not @sale.valid?
    assert_includes @sale.errors[:quantity_sold], 'must be greater than 0'

    @sale.quantity_sold = 0
    assert_not @sale.valid?
    assert_includes @sale.errors[:quantity_sold], 'must be greater than 0'
  end

  test 'adjust_inventory should adjust the inventory correctly' do
    initial_quantity = @inventory_item.quantity
    @sale.save
    assert_equal initial_quantity - @sale.quantity_sold, @inventory_item.reload.quantity
  end
end
