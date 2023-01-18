class ArticlesController < ApplicationController
  def index
    if params.key? :month_year
      date = Date.strptime(params[:month_year], "%B,%Y")
      date_range = date.beginning_of_month..date.end_of_month
      @articles = Article.where(created_at: date_range).paginate(page: params[:page], per_page: 5)
    else
      @articles = Article.paginate(page: params[:page], per_page: 5)
    end
    @archives = Article.group_by_month(:created_at).order(:created_at).reverse_order
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def show
    @article = Article.find(params[:id])
  end
private
  def article_params
    return params.require(:article).permit(:title, :text)
  end
end
