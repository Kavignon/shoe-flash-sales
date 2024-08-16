# frozen_string_literal: true

# This controller will handle the available shoes within a store.
class ShoesController < ApplicationController
  before_action :set_store
  before_action :set_shoe
  before_action :set_inventory_item, only: [:show]

  def index
    @shoes = @store.shoes
  end

  def show; end

  private

  def set_store
    @store = Store.find_by(id: params[:store_id])

    if @store.blank?
      flash[:alert] = 'Store not found'
      redirect_to stores_path
    end
  end

  def set_shoe
    @shoe = Shoe.find_by(id: params[:id])

    if @shoe.blank?
      flash[:alert] = 'Shoe not found'
      redirect_to store_shoes_path(@store)
    end
  end

  def set_inventory_item
    @inventory_item = InventoryItem.find_by(store: @store, shoe: @shoe)

    if @inventory_item.blank?
      flash[:alert] = 'Inventory item not found'
      redirect_to store_shoes_path(@store)
    end
  end
end
