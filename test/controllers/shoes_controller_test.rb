# frozen_string_literal: true

require 'test_helper'

class ShoesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @aldos_store = stores(:aldos_store)
    @running_shoe = shoes(:running_shoe)
    @aldos_running_shoes = inventory_items(:aldos_running_shoes)
  end

  test 'should get index for valid store' do
    get store_shoe_url(@aldos_store, @running_shoe) 
    assert_response :success
  end

  test 'should show shoe for valid store and shoe' do
    get store_shoe_url(@aldos_store, @running_shoe)
    assert_response :success
    assert_equal @running_shoe, assigns(:shoe)
    assert_equal @aldos_running_shoes, assigns(:inventory_item)
  end

  test 'should redirect to store shoes path with alert if store not found' do
    get store_shoe_url(store_id: 'nonexistent_store_id', id: @running_shoe.id)
    assert_redirected_to stores_path
    assert_equal 'Store not found', flash[:alert]
  end

  test 'should redirect to store shoes path with alert if shoe not found' do
    get store_shoe_url(store_id: @aldos_store.id, id: 'nonexistent_shoe_id')
    assert_redirected_to store_shoes_path(@aldos_store)
    assert_equal 'Shoe not found', flash[:alert]
  end

  test 'should not set flash alert for valid shoe and inventory item' do
    get store_shoe_url(@aldos_store, @running_shoe)
    assert_nil flash[:alert]
  end
end
