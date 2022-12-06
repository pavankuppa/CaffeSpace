class Offer < ApplicationRecord

  DISCOUNT = "discount"
  FREE = "free"

  validates_presence_of :name
  validates_presence_of :offer_type
  validates_uniqueness_of :name
  validates :offer_type, inclusion: { in: [DISCOUNT, FREE],
    message: "%{value} is not a valid offer type" }

  validates_presence_of :discount_percentage, :if => Proc.new { |o| o.offer_type == DISCOUNT }
  has_many :offer_items
  accepts_nested_attributes_for :offer_items

  scope :discount_offers, -> { where(offer_type: DISCOUNT)}
  scope :free_offers, -> { where(offer_type: FREE)}
end
