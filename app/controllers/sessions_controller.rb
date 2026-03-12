class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: create_permitted_params[:email])

    if user&.authenticate(create_permitted_params[:password])
      session[:auth_token] = user.auth_token
      redirect_to root_path, notice: I18n.t('sessions.create.success')
    else
      flash.now[:alert] = I18n.t('sessions.create.unprocessable_content')
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    session.delete(:auth_token)
    redirect_to root_path, notice: I18n.t('sessions.destroy.success')
  end

  private

  def create_permitted_params
    params.expect(session: %i[email password])
  end
end
