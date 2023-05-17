class Public::UsersController < ApplicationController

  def index
    @users = User.all
    @posts = Post.all
  end

  # def show
  #   @user = User.find(params[:id])# @posts = Posts.user_id(current_user)
  #   @posts = Post.where(user_id: @user.id)
  #   @following_users = @user.following_users
  #   @follower_users = @user.follower_users
  # end
  
  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id)
    @following_users = @user.followed_users
    @follower_users = @user.follower_users
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user#User.find(params[:id])
      if @user.update(user_params)
         flash[:success] = "登録情報を変更しました"
         redirect_to root_path
      else
         render :edit
      end
    # if @user.update(user_params)
    #   if @user = current_user
    #     redirect_to root_path, notice: "You have updated user successfully."
    #   else
    #     redirect_to admin_user_path(@user), notice: "You have updated user successfully."
    #   end
    # else
    #   # render "show"
    #   # render :edit
    # end
  end
  
  # def follows
  #   user = User.find(params[:id])
  #   @users = user.following_user.page(params[:page]).per(3).reverse_order
  # end
  def follows
    user = User.find(params[:id])
    @users = user.followed_users.reverse_order
  end

  # def followers
  #   user = User.find(params[:id])
  #   @users = user.follower_user.page(params[:page]).per(3).reverse_order
  # end
  def followers
    user = User.find(params[:id])
    @users = user.follower_users
  end


  private

  def user_params
    params.require(:user).permit(:email, :nickname, :like_toy_1, :like_toy_2, :like_toy_3,
      :play_ground_1, :play_ground_2, :play_ground_3, :introduction, :profile_image)
  end

end
