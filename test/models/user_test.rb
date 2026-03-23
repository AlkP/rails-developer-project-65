# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  auth_token      :string
#  provider_name   :string
#  provider        :string
#  uid             :string
#  name            :string
#  admin           :boolean          default(TRUE), not null
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
