class Variant < ApplicationRecord
  belongs_to :item
  validates :quantity, presence: true, uniqueness: { scope: :item_id }
  validates :price, presence: true
end
