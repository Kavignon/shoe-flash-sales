# frozen_string_literal: true

# Model class for representing the attributes and expected behavior for a Shoe in a store.
class Shoe < ApplicationRecord
  MINIMUM_PRICE = 49.99
  MAXIMUM_PRICE = 319.99
  FOOT_SIZES = %w[3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 11.5 12 12.5 13 13.5 14 14.5 15].freeze
  STYLES = %w[Basketball Running Formal Flats Dress Casual Boots Sandals].freeze
  COLORS = %w[White Black Red Blue Green Yellow].freeze

  validates :size, inclusion: { in: FOOT_SIZES.map(&:to_f), message: 'is not included in the list' }
  validates :style, inclusion: { in: STYLES }
  validates :color, inclusion: { in: COLORS }
  validates :price, numericality: { greater_than_or_equal_to: MINIMUM_PRICE, less_than_or_equal_to: MAXIMUM_PRICE }
  validates :brand_name, presence: true

  validates_uniqueness_of :brand_name, scope: %i[color size style], message: 'This shoe already is in store.'
end
