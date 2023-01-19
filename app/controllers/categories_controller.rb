class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was been created"
      redirect_to @category
    else
      render 'new'
    end
  end

  def index
    @categories = Category.all
  end

  def show
    @articles = @category
                  .articles
                  .order(:created_at)
                  .reverse_order
                  .paginate(page: params[:page], per_page: 5)
  end

  def edit
  end

  def update
    if @category.update category_params
      flash[:notice] = "Category named updated"
      redirect_to @category
    end
  end

  def destroy
    @category.destroy
    redirect_to articles_path
  end

private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "You do not have admin permission"
      redirect_to categories_path
    end
  end
end
