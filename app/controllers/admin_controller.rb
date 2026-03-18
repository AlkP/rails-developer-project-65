class AdminController < ApplicationController
  # before_action :authenticate_admin!
  before_action :set_bulletin, only: %i[archive]

  def index
    @bulletins = Bulletin.search(params[:q]).by_state(params[:state]).ordered
    authorize @bulletins

    @bulletins = @bulletins.paginate(page: params[:page], per_page: PER_PAGE)
  end

  def archive
    @bulletin.archive!

    redirect_to admin_index_path
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end
end
