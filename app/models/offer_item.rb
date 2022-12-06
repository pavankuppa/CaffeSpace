class OfferItem < ApplicationRecord
  belongs_to :offer
  belongs_to :variant
end
