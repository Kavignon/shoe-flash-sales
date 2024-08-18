# frozen_string_literal: true

# This controller will handle the store selection and show the shoes available in a store.
class StoresController < ApplicationController
  before_action :set_store, only: [:show]
  before_action :set_breadcrumbs

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

  def set_breadcrumbs
    @breadcrumbs = [
      { name: 'Stores', url: root_path }
    ]
  end
end
