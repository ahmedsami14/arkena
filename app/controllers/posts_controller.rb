class PostsController < ApplicationController
    before_action :set_post, only: %i[ show edit update destroy ]
    before_action :authenticate_user!, only: [:create]
    
    def index
      @posts = Post.all
      render json: { posts: @posts }
    end
  
    def show
      @post = Post.find(params[:id])
    end
  
    def new
      @post = current_user.posts.build
    end
  
    def create 
      @post = current_user.posts.build(post_params)
      tag_names = params[:post][:tag_names]

      if tag_names.present?
        tags = tag_names.map { |tag_name| Tag.find_or_create_by(name: tag_name) }
        @post.tags = tags
      end

      if @post.save
        render json: { message: 'Post was successfully created.', post: @post }, status: :created
      else
        render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # Define edit, update, and destroy actions as needed
  
    private
  
    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :tags, :comments , :user_id)
    end
  end
  
