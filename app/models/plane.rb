class Plane < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations, dependent: :destroy

  validates :model, presence: true
  validates :registration, presence: true
  validates :description, presence: true
  validates :cruise_speed, presence: true
  validates :tour_price, presence: true
  validates :picture, presence: true
end
