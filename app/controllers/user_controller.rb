class UserController < ApplicationController
  def index
    @user_list = User.all
  end

  def show
    @this_user = User.find(params[:id])
  end
end
