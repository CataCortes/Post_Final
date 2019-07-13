class PostsController < ApplicationController

  def index
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: params[:id]) # Esto es lo mismo que Post.comments gracias al has_many
    @comment = @post.comments.new
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      redirect_to post_path(post)
    else
      flash[:errors] = post.errors.messages
      redirect_to root_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    post = Post.update(post_params)
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path(post)
  end

  private

  def post_params
    params.require( :post).permit(:title, :description)
  end
end
