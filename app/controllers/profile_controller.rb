class ProfileController < ApplicationController
  before_action :set_bulletin, only: %i[edit update to_moderate archive]

  def index
    bulletins = Bulletin.by_user_id(current_user.id).search(params[:q]).by_state(params[:state]).ordered
    authorize bulletins

    @bulletins = bulletins.paginate(page: params[:page], per_page: PER_PAGE)
  end

  def show; end

  def new
    @bulletin = Bulletin.new
    authorize @bulletin
  end

  def edit; end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    authorize @bulletin

    if @bulletin.save
      redirect_to profile_index_path, notice: I18n.t('bulletins.create.info')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @bulletin.update(bulletin_params)
      redirect_to profile_index_path, notice: I18n.t('bulletins.update.info')
    else
      render :edit, status: :unprocessable_content
    end
  end

  def to_moderate
    @bulletin.to_moderate!

    redirect_to profile_index_path
  end

  def archive
    @bulletin.archive!

    redirect_to profile_index_path
  end

  private

  def set_bulletin
    @bulletin = Bulletin.by_user_id(current_user.id).find(params[:id])
    authorize @bulletin
  end

  def bulletin_params
    params.expect(bulletin: %i[title description category_id image])
  end
end
