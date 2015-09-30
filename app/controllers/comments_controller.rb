class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :destroy
  before_action :authenticate_admin, only: :destroy

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    if (user_signed_in?)
      @comment.commenter = current_user.name
    else
      @comment.commenter = "Anonymous"
    end
    @comment.save
    redirect_to article_path(@article)
  end
 
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:body)
    end
    def authenticate_admin
      unless current_user.authority == 2
        redirect_to :back
      end
    end
end
