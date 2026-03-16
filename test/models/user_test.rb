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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
