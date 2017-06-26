class SubsController < ApplicationController
  before_action :require_logged_in, except: [:show, :index]
  before_action :require_user_owns_sub, only: [:edit, :update, :destroy]

  def new
    @sub = Sub.new
    render :new
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      redirect_to :edit
    end
  end

  def destroy
    @sub = current_user.subs.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  private

  def require_user_owns_sub!
    return if current_user.subs.find(params[:id])
    render json: "Forbidden", status: :forbidden
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
