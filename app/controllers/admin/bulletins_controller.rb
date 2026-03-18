class Admin::BulletinsController < ApplicationController
  # before_action :authenticate_admin!
  before_action :set_bulletin, only: %i[publish reject archive]

  def index
    bulletins = Bulletin.under_moderation.ordered
    bulletins = bulletins.search(params[:q]) if params[:q].present?

    @bulletins = bulletins.paginate(page: params[:page], per_page: PER_PAGE)
    authorize @bulletins
  end

  def publish
    @bulletin.publish!

    redirect_to admin_bulletins_path
  end

  def reject
    @bulletin.reject!

    redirect_to admin_bulletins_path
  end

  def archive
    @bulletin.archive!

    redirect_to admin_bulletins_path
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end
end
