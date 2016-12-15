class Shoe < ActiveRecord::Base
  belongs_to :user

  # Validations
  validates :name, :price, :presence => true
  validates_numericality_of :price
end
