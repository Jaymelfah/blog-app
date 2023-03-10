class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { comment: @comment } }
    end
  end

  def create
    @user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    @comment = @user.comments.new(comments_params)
    @comment.user_id = @user.id
    @comment.author_id = @user.id
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:notice] = 'Comment successfully created!'
      redirect_to user_post_path(@user.id, post)
    else
      flash.now[:error] = 'Error: Comment creation not successful'
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find_by!(id: params[:post_id])
    comment = Comment.find_by!(post_id: params[:post_id], id: params[:id])
    comment.destroy
    @post.decrement!(:comments_counter)
    flash[:notice] = 'The comment was deleted'
    redirect_to user_post_path(@user, @post)
  end

  def comments_params
    params.require(:comment).permit(:text)
  end
end
