class Api::V1::CommentsController < Api::V1::ApplicationController
    def index
      comments = Comment.where(post_id: params[:post_id], author_id: current_user.id)
      render json: comments, status: :ok
    end
  
    def create
      post_id = params[:post_id]
      text = params[:text]
      comment = Comment.new(text: text, post_id: post_id, author_id: current_user.id, user_id: current_user.id)
  
      if comment.save
        render json: comment, status: :ok
      else
        render json: comment.errors, status: :unprocessable_entity
      end
    end
end