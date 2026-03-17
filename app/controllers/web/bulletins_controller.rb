class Web::BulletinsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  PER_PAGE = 8

  def index
    bulletins = Bulletin.ordered
    bulletins = bulletins.search(params[:q]) if params[:q].present?

    @bulletins = bulletins.paginate(page: params[:page], per_page: PER_PAGE)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    @bulletin = Bulletin.new
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to root_path, notice: I18n.t('bulletins.create.info')
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def bulletin_params
    params.expect(bulletin: %i[title description category_id image])
  end
end
