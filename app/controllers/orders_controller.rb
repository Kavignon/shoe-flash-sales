# frozen_string_literal: true

# This controller handles creating sales from ordered shoes
class OrdersController < ApplicationController
  before_action :set_store
  before_action :set_shoe
  before_action :set_inventory_item

  INSUFFICIENT_STOCK_IN_INVENTORY_ALERT_MESSAGE = 'Insufficient stock in inventory for this shoe'
  INVALID_QUANTITY_ALERT_MESSAGE = 'Invalid quantity'
  STORE_NOT_FOUND_ALERT_MESSAGE = 'Store not found'
  SHOE_NOT_FOUND_ALERT_MESSAGE = 'Shoe not found'
  INVENTORY_ITEM_NOT_FOUND_ALERT_MESSAGE = 'Inventory item not found'

  INVALID_QUANTITY_ERROR_MESSAGE = 'When ordering a shoe, the quantity has to be over 0.'

  SUCCESSFUL_ORDER_PLACED_ALERT_MESSAGE = 'Order placed successfully'

  def create
    quantity = params[:quantity].to_i

    handle_error_in_order(INVALID_QUANTITY_ALERT_MESSAGE, INVALID_QUANTITY_ERROR_MESSAGE) and return if quantity <= 0
    handle_error_in_order(INSUFFICIENT_STOCK_IN_INVENTORY_ALERT_MESSAGE, insufficient_stock_message(quantity)) and return if @inventory_item.quantity < quantity

    generate_sale(quantity)
    handle_valid_order(quantity)
  rescue ActiveRecord::RecordInvalid => e
    handle_error_in_order("Error processing order: #{e.message}", order_error_message(e))
  end

  private

  def handle_error_in_order(alert_message, error_message)
    Rails.logger.error(error_message)
    flash[:alert] = alert_message

    redirect_to store_path(@store)
  end

  def handle_valid_order(quantity)
    Rails.logger.info order_success_message(quantity)
    flash[:notice] = SUCCESSFUL_ORDER_PLACED_ALERT_MESSAGE
    redirect_to store_path(@store)
  end

  def insufficient_stock_message(quantity)
    "Insufficient stock for Shoe ID: #{@shoe.id} at Store ID: #{@store.id}. Requested: #{quantity}, Available: #{@inventory_item.quantity}"
  end

  def order_success_message(quantity)
    "Order placed successfully: Store ID: #{@store.id}, Shoe ID: #{@shoe.id}, Quantity: #{quantity}"
  end

  def generate_sale(quantity)
    Sale.create!(
      inventory_item_id: @inventory_item.id,
      quantity_sold: quantity
    )
    @inventory_item.adjust_quantity!(quantity_sold: quantity)
  end

  def order_error_message(exception)
    "Error processing order for Shoe ID: #{@shoe.id} at Store ID: #{@store.id}: #{exception.message}"
  end

  def set_store
    @store = Store.find(params[:store_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = STORE_NOT_FOUND_ALERT_MESSAGE
    redirect_to stores_path
  end

  def set_shoe
    @shoe = Shoe.find(params[:shoe_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = SHOE_NOT_FOUND_ALERT_MESSAGE
    redirect_to store_path(@store)
  end

  def set_inventory_item
    @inventory_item = InventoryItem.find_by!(store: @store, shoe: @shoe)
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = INVENTORY_ITEM_NOT_FOUND_ALERT_MESSAGE
    redirect_to store_path(@store)
  end
end
