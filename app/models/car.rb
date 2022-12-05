class Car < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :name, :car_type, :brand, :color, :image, presence: true
  validates :amount, numericality: { only_float: true, greater_than: 0 }
end
