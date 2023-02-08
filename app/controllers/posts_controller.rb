class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def new
    @post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    current_user = User.find(params[:user_id])
    @post = Post.new(post_params)
    @post.author = current_user
    @post.author_id = current_user.id
    @post.user_id = current_user.id
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      flash[:notice] = 'Post successfully created!'
      redirect_to user_posts_path(current_user)
    else
      flash.now[:error] = 'Error: Error occurred when creating post'
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find_by!(id: params[:id], author_id: params[:user_id])
  end

  def destroy
    current_user = User.find(params[:user_id])
    post = Post.find_by!(id: params[:id])
    post.destroy
    current_user.decrement!(:posts_counter)
    flash[:notice] = 'The post was deleted'
    redirect_to user_posts_path(current_user)
  end

  private

  def post_params
    params.require(:new_post).permit(:title, :text)
  end
end
