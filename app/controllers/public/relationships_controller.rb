class Public::RelationshipsController < ApplicationController
  
  # def create
  #   current_user.follow(params[:user_id])
  #   redirect_to request.referer
  # end
  
  # def destroy
  #   current_user.unfollow(params[:user_id])
  #   redirect_to request.referer
  # end

  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end

  
end
