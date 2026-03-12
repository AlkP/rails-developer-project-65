class UsersController < ApplicationController
  def index; end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:auth_token] = @user.auth_token
      redirect_to root_path, notice: I18n.t('users.new.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def user_params
    params.expect(user: %i[email password password_confirmation])
  end
end
