class House < ApplicationRecord
  belongs_to :user
  has_many :house_bookings
end
