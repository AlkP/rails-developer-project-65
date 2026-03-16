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
#  provider_name   :string
#  provider        :string
#  uid             :string
#
# Indexes
#
#  index_users_on_auth_token  (auth_token) UNIQUE
#  index_users_on_email       (email) UNIQUE
#

class User < ApplicationRecord
  has_secure_password validations: false

  validates :email, presence: true, uniqueness: true
  # validates :auth_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { provider.blank? && new_record? }

  before_create :generate_auth_token

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider_name = auth.info.nickname
      user.email = auth.info.email
    end
  end

  private

  def generate_auth_token
    self.auth_token = loop do
      random_token = SecureRandom.hex(16)
      next if User.exists?(auth_token: random_token)

      break random_token
    end
  end
end
