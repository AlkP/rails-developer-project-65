class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  attr_reader :current_user

  before_action :set_current_user

  private

  def set_current_user
    @current_user = User.find_by(auth_token: session[:auth_token]) if session[:auth_token]
  end

  helper_method :current_user
end
