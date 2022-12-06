class OrderItem < ApplicationRecord
  belongs_to :order
  validates_presence_of :item_name
  validates_presence_of :quantity
  validates_presence_of :price
end
