class Admin::BulletinsController < ApplicationController
  # before_action :authenticate_admin!

  def index
    bulletins = Bulletin.ordered
    bulletins = bulletins.search(params[:q]) if params[:q].present?

    @bulletins = bulletins.paginate(page: params[:page], per_page: PER_PAGE)
    authorize @bulletins
  end

  def publish
    redirect_to admin_bulletins_path
  end

  def reject
    redirect_to admin_bulletins_path
  end

  def archive
    redirect_to admin_bulletins_path
  end
end
