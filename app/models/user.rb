class User < ApplicationRecord
  has_many :sessions, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true 
  validates  :image_url , presence: true
  validates :date_of_birth, presence: true
end
