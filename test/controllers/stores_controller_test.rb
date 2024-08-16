# frozen_string_literal: true

require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
  def setup
    @aldo_store = stores(:aldos_store)
  end

  test 'should get index' do
    get stores_url
    assert_response :success
  end

  test 'should get show' do
    get store_url(@aldo_store)
    assert_response :success
  end

  test 'should redirect to index with alert if store not found' do
    get store_url(id: 'nonexistent_id')
    assert_redirected_to stores_path
    assert_equal 'Store not found', flash[:alert]
  end

  test 'should not set flash alert for valid store' do
    get store_url(@aldo_store)
    assert_nil flash[:alert]
  end

  test 'should assign @store and @shoes for valid store' do
    get store_url(@aldo_store)
    assert_equal @aldo_store, assigns(:store)
    assert_equal @aldo_store.shoes, assigns(:shoes)
  end
end
