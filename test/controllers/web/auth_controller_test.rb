require 'test_helper'

class Web::AuthControllerTest < ActionDispatch::IntegrationTest
  test 'should get request' do
    get auth_request_path(:github)

    assert_response :redirect
  end

  test 'should get callback' do
    get callback_auth_path(:github)

    assert_response :redirect
  end
end
