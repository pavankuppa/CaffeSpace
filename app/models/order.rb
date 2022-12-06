class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy

  validates_uniqueness_of :order_number
  validates_presence_of :order_price

  accepts_nested_attributes_for :order_items

  before_create :set_order_number

  IN_PROGRESS = "inprogress"
  PROCESSED = "processed"

  private

  def set_order_number
    last_id =  Order.maximum(:id) || 0
    self.order_number = "ORD#{ last_id.next.to_s.rjust(3, '0')}"
  end
end
