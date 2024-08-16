# frozen_string_literal: true

# This controller handles creating sales from ordered shoes
class OrdersController < ApplicationController
  before_action :set_store
  before_action :set_shoe
  before_action :set_inventory_item

  def create
    quantity = params[:quantity].to_i

    if quantity <= 0
      flash[:alert] = 'Invalid quantity'
      redirect_to store_path(@store) and return
    end

    if @inventory_item.quantity < quantity
      handle_insufficient_stock(quantity)
      return
    end

    process_order(quantity)
  rescue ActiveRecord::RecordInvalid => e
    handle_order_error(e)
  end

  private

  def handle_insufficient_stock(quantity)
    Rails.logger.error insufficient_stock_message(quantity)
    flash[:alert] = 'Insufficient stock'
    redirect_to store_path(@store)
  end

  def insufficient_stock_message(quantity)
    "Insufficient stock for Shoe ID: #{@shoe.id} at Store ID: #{@store.id}. Requested: #{quantity}, Available: #{@inventory_item.quantity}"
  end

  def process_order(quantity)
    generate_sale(quantity)
    Rails.logger.info order_success_message(quantity)
    flash[:notice] = 'Order placed successfully'
    redirect_to store_path(@store)
  end

  def order_success_message(quantity)
    "Order placed successfully: Store ID: #{@store.id}, Shoe ID: #{@shoe.id}, Quantity: #{quantity}"
  end

  def generate_sale(quantity)
    Sale.create!(
      inventory_item_id: @inventory_item.id,
      quantity_sold: quantity,
    )
    @inventory_item.adjust_quantity!(quantity_sold: quantity)
  end

  def handle_order_error(exception)
    Rails.logger.error order_error_message(exception)
    flash[:alert] = "Error processing order: #{exception.message}"
    redirect_to store_path(@store)
  end

  def order_error_message(exception)
    "Error processing order for Shoe ID: #{@shoe.id} at Store ID: #{@store.id}: #{exception.message}"
  end

  def set_store
    @store = Store.find(params[:store_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Store not found'
    redirect_to stores_path
  end

  def set_shoe
    @shoe = Shoe.find(params[:shoe_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Shoe not found'
    redirect_to store_path(@store)
  end

  def set_inventory_item
    @inventory_item = InventoryItem.find_by!(store: @store, shoe: @shoe)
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Inventory item not found'
    redirect_to store_path(@store)
  end
end
