module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :user_signed_in?
  end

  def current_user
    @current_user ||= User.find_by(auth_token: session[:auth_token]) if session[:auth_token]
  end

  def authenticate_user!
    return if user_signed_in?

    redirect_to root_path, alert: I18n.t('sessions.alert')
  end

  def user_signed_in?
    current_user.present?
  end
end
