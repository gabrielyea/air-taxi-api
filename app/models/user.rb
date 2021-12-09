class User < ApplicationRecord
  has_many :reservations
  has_many :planes, through: :reservations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  def jwt_payload
    { user: as_json }
  end
end
