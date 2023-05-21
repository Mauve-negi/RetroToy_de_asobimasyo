class Public::PostsController < ApplicationController
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end
  
  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      flash[:notice] = "投稿できました"
      redirect_to users_path#post_path(@post.id)
    else
      @posts = Post.all
      render :index
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to users_path#'/posts/index'
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :body, :image, :post_type)
  end
  
end