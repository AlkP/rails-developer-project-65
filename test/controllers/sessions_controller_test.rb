require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_session_path

    assert_response :success
  end

  test 'should create session with valid credentials' do
    user = users(:one)
    post sessions_url, params: { session: { email: user.email, password: 'MyPassword' } }

    assert_response :redirect
    assert_redirected_to root_path
    assert_equal user.reload.auth_token, session[:auth_token]
  end

  test 'should not create session with invalid credentials' do
    post sessions_url, params: { session: { email: 'invalid@email.com', password: 'wrong' } }

    assert_response :unprocessable_entity
    assert_not session[:auth_token]
  end

  test 'should destroy session' do
    get root_path
    user = users(:one)
    session[:auth_token] = user.auth_token
    delete sessions_url

    assert_response :redirect
    assert_redirected_to root_path
    assert_not session[:auth_token]
  end

  test 'should not destroy non-existent session' do
    delete sessions_url

    assert_response :redirect
    assert_redirected_to root_path
    assert_not session[:auth_token]
  end
end
