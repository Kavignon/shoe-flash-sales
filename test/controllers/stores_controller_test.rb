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

  test 'index should list all stores' do
    get stores_url
    assert_not_nil assigns(:stores)

    assigns(:stores).each do |store|
      assert_not_nil store.shoes
    end
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

  test 'should assign @shoes for valid store in show action' do
    get store_url(@aldo_store)
    assert_response :success
    assert_not_nil assigns(:shoes)
    assert_equal @aldo_store.shoes, assigns(:shoes)

    expected_shoes = @aldo_store.shoes
    assert_equal expected_shoes.count, assigns(:shoes).count

    assigns(:shoes).each do |shoe|
      assert_includes expected_shoes, shoe
    end
  end
end
