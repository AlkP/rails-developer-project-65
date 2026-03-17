class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = Category.ordered.paginate(page: params[:page], per_page: PER_PAGE)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: 'Категория создана'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    p 'sa'
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: 'Категория обновлена'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.bulletins.exists?
      redirect_to admin_categories_path, alert: 'Нельзя удалить категорию с объявлениями'
    else
      @category.destroy
      redirect_to admin_categories_path, notice: 'Категория удалена'
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end