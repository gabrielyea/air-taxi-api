class User < ApplicationRecord
  has_many :reservations
  has_many :planes, through: :reservations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  validates :name, length: { minimum: 5 }
  validates :email, presence: { message: 'Email can not be empty' }
  validates :password, length: { in: 6..20 }

  def jwt_payload
    { user: as_json }
  end
end
