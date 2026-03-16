class ActionDispatch::IntegrationTest
  def sign_in(user, _options = {})
    auth_hash = {
      provider: 'github',
      uid: '12345',
      info: {
        email: user.email,
        name: user.name
      }
    }

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)

    get callback_auth_url('github')
  end

  def signed_in?
    session[:auth_token].present? && current_user.present?
  end

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = User.find_by(auth_token: session[:auth_token])
  end
end
