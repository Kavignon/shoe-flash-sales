class Store < ApplicationRecord
  validates :name, presence: true
  has_many :inventory_items, dependent: :destroy
end
