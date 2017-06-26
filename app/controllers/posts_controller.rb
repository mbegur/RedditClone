class PostsController < ApplicationController
  before_action :require_logged_in, except: [:show]
  before_action :require_user_owns_post, only: [:update, :edit, :destroy]

  def new
    @post = Post.new
    @post.sub_id = params[:sub_id]
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub)
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end

  def require_user_owns_post
    return if current_user.posts.find(params[:id])
    render json: "Forbidden", status: :forbidden
  end
end
