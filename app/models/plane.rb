class Plane < ApplicationRecord
  has_many :reservations
  has_many :users, through: :reservations

  validates :model, presence: true
  validates :registration, presence: true
  validates :description, presence: true
  validates :cruise_speed, presence: true
  validates :tour_price, presence: true
  validates :picture, presence: true
end
