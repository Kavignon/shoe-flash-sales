# frozen_string_literal: true

# This controller will handle the store selection and show the shoes available in a store.
class StoresController < ApplicationController
  before_action :set_store, only: [:show]

  def index
    @stores = Store.all
  end

  def show
    @shoes = @store.shoes
  end

  private

  def set_store
    @store = Store.find_by(id: params[:id])

    if @store.blank?
      flash[:alert] = 'Store not found'
      redirect_to stores_path
    end
  end
end
