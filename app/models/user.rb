class User < ApplicationRecord
  has_many :sessions, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_secure_password
  validates :name, presence: true 
end
