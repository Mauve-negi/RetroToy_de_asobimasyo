# class Public::SearchesController < ApplicationController
  
#   before_action :authenticate_user!

#   # def search
#   #   @range = params[:range]

#   #   if @range == "ユーザ"
#   #     @users = User.looks(params[:search], params[:word])
#   #   else
#   #     @posts = Post.looks(params[:search], params[:word])
#   #   end
#   # end

#   def search
#     @range = params[:range]
#     @word = params[:word]
#     @post_type = params[:post_type]

#     if @range == "ユーザ"
#       @users = User.looks(params[:search], @word)
#     else
#       @posts = Post.looks(params[:search], @word).where(post_type: @post_type)
#     end
#   end
  
# end

class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    @post_type = params[:post_type]

    if @range == "ユーザ"
      @users = User.looks(params[:search], @word)
    else
      @posts = Post.looks(params[:search], @word)
      @posts = @posts.where(post_type: @post_type) if @post_type.present?
    end
  end
end