class Admin::CategoriesController < ApplicationController
  # before_action :authenticate_admin!
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = Category.ordered.paginate(page: params[:page], per_page: PER_PAGE)
    authorize @categories
  end

  def new
    @category = Category.new
    authorize @category
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    authorize @category

    if @category.save
      redirect_to admin_categories_path, notice: t('admin.categories.messages.created')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('admin.categories.messages.updated')
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @category.bulletins.exists?
      redirect_to admin_categories_path, alert: t('admin.categories.messages.cannot_delete', count: @category.bulletins.count)
    else
      @category.destroy
      redirect_to admin_categories_path, notice: t('admin.categories.messages.destroyed')
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
    authorize @category
  end

  def category_params
    params.expect(category: [:name])
  end
end
