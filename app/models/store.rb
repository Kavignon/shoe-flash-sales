# frozen_string_literal: true

class Store < ApplicationRecord
  after_create :log_creation

  validates :name, presence: true, uniqueness: true

  has_many :inventory_items, dependent: :destroy
  has_many :shoes, through: :inventory_items
  has_many :sales, through: :inventory_items, dependent: :destroy

  def total_inventory_value
    inventory_items.joins(:shoe).pluck('quantity', 'shoes.price').map do |quantity, price|
      quantity.to_f * price.to_f
    end.sum
  end

  def high_stock_items
    inventory_items.select(&:high_stock?)
  end

  def low_stock_items
    inventory_items.select(&:low_stock?)
  end

  def trendiest_items(limit = 5)
    inventory_items
      .joins(:sales)
      .group('inventory_items.id', 'shoes.id')
      .order('SUM(sales.quantity_sold) DESC')
      .limit(limit)
      .pluck('inventory_items.id, shoes.brand_name, shoes.style, SUM(sales.quantity_sold) AS total_sold')
  end

  private

  def log_creation
    Rails.logger.info "Store #{name} created with ID: #{id}"
  end
end
