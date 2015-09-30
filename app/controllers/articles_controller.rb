class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :check_author, only: [:new, :create, :update, :edit, :destroy]
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)

    if @article.save
      if @article.title == ""
        @article.tag_list.add("Tweet")
        @article.save
      end
      redirect_to @article
    else
      render 'new'
    end
  end
  
  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      if @article.title == ""
        @article.tag_list.add("Tweet")
        @article.save
      end
      redirect_to @article
    else
      render 'edit'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end 

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
  
    redirect_to articles_path
  end
  def tagsearch
    @filter = params[:name]
  end
  def show
    @article = Article.find(params[:id])
  end

 
  def index
    @articles = Article.all
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :text, :photo, :tag_list, :audio)
    end

    def check_author
      unless current_user.authority == 2
        redirect_to :back, notice: "Permission Denied :( "
      end
    end

end
