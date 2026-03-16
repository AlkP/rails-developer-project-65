module Web
  class AuthController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:callback]

    def callback
      auth = request.env['omniauth.auth']

      if auth.present?
        user = User.from_omniauth(auth)

        if user.persisted?
          session[:auth_token] = user.auth_token
          redirect_to root_path, notice: I18n.t('web.auth.success')
        else
          redirect_to root_path, alert: I18n.t('web.auth.user_alert')
        end
      else
        redirect_to root_path, alert: I18n.t('web.auth.alert')
      end
    end
  end
end
