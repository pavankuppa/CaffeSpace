class Variant < ApplicationRecord
  belongs_to :item
  validates :quantity, presence: true, uniqueness: { scope: :item_id }
  validates :price, presence: true


  def discounted_price(discount)
    price - ( price / 100 ) * discount
  end
end
