class Admin::UsersController < ApplicationController

  # def index
  #   @users = User.all
  #   @posts = Post.where(user_id: current_user.id)
  # end
  
  def index
    @users = User.all
    @posts = Post.all
  end

  def show
    @user = User.find(params[:id])
    # @posts = Posts.user_id(current_user)
    @posts = Post.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      if @user = current_user
        redirect_to root_path, notice: "You have updated user successfully."
      else
        redirect_to admin_user_path(@user), notice: "You have updated user successfully."
      end
    else
      # render "show"
      # render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname, :like_toy_1, :like_toy_2, :like_toy_3,
      :play_ground_1, :play_ground_2, :play_ground_3)
  end

end
