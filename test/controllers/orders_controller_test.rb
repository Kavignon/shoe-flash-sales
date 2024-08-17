# frozen_string_literal: true

require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @store = stores(:aldos_store)
    @shoe = shoes(:running_shoe)
    @inventory_item = inventory_items(:aldos_running_shoes)
  end

  test 'should create sale with valid order' do
    post create_order_url, params: { store_id: @store.id, shoe_id: @shoe.id, quantity: 5 }

    assert_response :redirect
    assert_redirected_to store_path(@store)
    assert_equal OrdersController::SUCCESSFUL_ORDER_PLACED_ALERT_MESSAGE, flash[:notice]
    assert_nil flash[:alert]

    assert Sale.exists?(inventory_item_id: @inventory_item.id, quantity_sold: 5)
    assert_equal 45, @inventory_item.reload.quantity
  end

  test 'should redirect with alert for invalid quantity' do
    post create_order_url, params: { store_id: @store.id, shoe_id: @shoe.id, quantity: 0 }

    assert_response :redirect
    assert_redirected_to store_path(@store)
    assert_equal OrdersController::INVALID_QUANTITY_ALERT_MESSAGE, flash[:alert]
  end

  test 'should redirect with alert for insufficient stock' do
    @inventory_item.update(quantity: 3)

    post create_order_url, params: { store_id: @store.id, shoe_id: @shoe.id, quantity: 10 }

    assert_response :redirect
    assert_redirected_to store_path(@store)
    assert_equal OrdersController::INSUFFICIENT_STOCK_IN_INVENTORY_ALERT_MESSAGE, flash[:alert]
  end

  test 'should redirect with alert when store is not found' do
    post create_order_url, params: { store_id: 'nonexistent_store_id', shoe_id: @shoe.id, quantity: 5 }

    assert_response :redirect
    assert_redirected_to stores_path
    assert_equal OrdersController::STORE_NOT_FOUND_ALERT_MESSAGE, flash[:alert]
  end

  test 'should redirect with alert when shoe is not found' do
    post create_order_url, params: { store_id: @store.id, shoe_id: 'nonexistent_shoe_id', quantity: 5 }

    assert_response :redirect
    assert_redirected_to store_path(@store)
    assert_equal OrdersController::SHOE_NOT_FOUND_ALERT_MESSAGE, flash[:alert]
  end

  test 'flash messages for invalid quantity' do
    post create_order_url, params: { store_id: @store.id, shoe_id: @shoe.id, quantity: 0 }

    assert_equal OrdersController::INVALID_QUANTITY_ALERT_MESSAGE, flash[:alert]
    assert_nil flash[:notice]
  end

  test 'flash messages for insufficient stock' do
    @inventory_item.update(quantity: 3)

    post create_order_url, params: { store_id: @store.id, shoe_id: @shoe.id, quantity: 10 }

    assert_equal OrdersController::INSUFFICIENT_STOCK_IN_INVENTORY_ALERT_MESSAGE, flash[:alert]
    assert_nil flash[:notice]
  end
end
