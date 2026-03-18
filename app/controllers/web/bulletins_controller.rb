class Web::BulletinsController < ApplicationController
  # before_action :authenticate_user!, only: %i[new create]

  PER_PAGE = 8

  def index
    bulletins = Bulletin.published.search(params[:q]).ordered

    @bulletins = bulletins.paginate(page: params[:page], per_page: PER_PAGE)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    authorize @bulletin

    if @bulletin.save
      redirect_to root_path, notice: I18n.t('bulletins.create.info')
    else
      render :new, status: :unprocessable_content
    end
  end
end
