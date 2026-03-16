# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  auth_token      :string
#  created_at      :datetime         not null
#  email           :string           not null
#  password_digest :string
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_auth_token  (auth_token) UNIQUE
#  index_users_on_email       (email) UNIQUE
#

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
