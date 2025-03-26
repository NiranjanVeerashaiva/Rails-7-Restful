class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = Article.all
  end

  def show
    @article.update(read: true)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
    if @article.update(article_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
