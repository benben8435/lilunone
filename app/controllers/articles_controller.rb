class ArticlesController < ApplicationController
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
  
  http_basic_authenticate_with name: "benben8435", password: "yyggnnhh", 
    except: [:index, :show, :tagsearch]
 
  def index
    @articles = Article.all
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :text, :photo, :tag_list, :audio)
    end
end
