class Item < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :variants
  accepts_nested_attributes_for :variants
end
