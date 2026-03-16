class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(auth_token: session[:auth_token]) if session[:auth_token]
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    return if logged_in?

    redirect_to root_path, alert: I18n.t('sessions.alert')
  end
end
