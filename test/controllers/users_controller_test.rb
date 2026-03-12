require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_user_path

    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_path, params: {
        user: {
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }
    end
    assert_redirected_to root_path
  end

  test 'should get show' do
    user = users(:one)
    get user_path(user)

    assert_response :success
  end

  test 'should get index' do
    get users_path

    assert_response :success
  end
end
