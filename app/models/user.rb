class User < ApplicationRecord
  has_many :air_conditioner, dependent: :destroy
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  devise :database_authenticatable, authentication_keys: [:username]

  enum role: %i[user admin]

  def self.authenticate(username, password)
    user = User.find_for_authentication(username:)
    user&.valid_password?(password) ? user : nil
  end
end
