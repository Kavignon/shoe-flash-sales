class Shoe < ApplicationRecord
  FOOT_SIZES = %w[3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 11.5 12 12.5 13 13.5 14 14.5 15].freeze
  SHOE_STYLES = %w[Basketball Running Formal Flats Dress Casual Boots Sandals].freeze

  validates :size, inclusion: { in: FOOT_SIZES }
  validates :style, inclusion: { in: SHOE_STYLES }
end
