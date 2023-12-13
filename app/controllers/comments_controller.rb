class CommentsController < ApplicationController

    before_action :set_comment, only: %i[ show edit update destroy ]
    before_action :authenticate_user!, only: [:create]
    
    def index
      @post = Post.find(params[:post_id])  
      @comments = @post.comments
      render json: { comments: @comments }
    end
  
    def show
      @comment = Comment.find(params[:id])
      render json: { comment: @comment }
    end
  
    def new
      @comment = current_user.comments.build
    end
  
    def create 
      @comment = current_user.comments.build(comment_params)
      if @comment.save
        render json: { message: 'Comment was successfully created.', comment: @comment }, status: :created
      else
        render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
            render json: { message: 'Comment was successfully updated.', comment: @comment }, status: :ok
        else
            render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
        end
    end
  
    # Define edit, update, and destroy actions as needed
  
    private
  
    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :post_id, :user_id)
    end

end
