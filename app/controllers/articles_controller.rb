class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    if params.key? :month_year
      date = Date.strptime(params[:month_year], "%B,%Y")
      date_range = date.beginning_of_month..date.end_of_month
      @articles = Article.where(created_at: date_range).order(:created_at).reverse_order.paginate(page: params[:page], per_page: 5)
    else
      @articles = Article.order(:created_at).reverse_order.paginate(page: params[:page], per_page: 5)
    end
    @archives = Article.group_by_month(:created_at).order(:created_at).reverse_order
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @article.destroy
    redirect_back fallback_location: root_path
  end
private
  def article_params
    return params.require(:article).permit(:title, :text)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You do not have permission to modify this article"
      redirect_to @article
    end
  end
end
