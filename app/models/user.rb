class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  # validates :auth_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  before_create :generate_auth_token

  private

  def generate_auth_token
    self.auth_token = loop do
      random_token = SecureRandom.hex(16)
      next if User.exists?(auth_token: random_token)

      break random_token
    end
  end
end
