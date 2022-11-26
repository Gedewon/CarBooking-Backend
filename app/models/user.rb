class User < ApplicationRecord
  has_many :sessions, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_secure_password
end
