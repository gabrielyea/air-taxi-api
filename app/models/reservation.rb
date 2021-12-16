class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :plane

  validates :reserve_date, presence: true, uniqueness: { scope: :user_id }
end
