class TagsController < ApplicationController
    def index
        @tags = Tag.all
    end
    
    def show
        @tag = Tag.find_by(name: params[:id])
        @posts = @tag.posts
    end

    def create
        @tag = Tag.new(tag_params)
        if @tag.save
            render json: {message: "Tag was successfully created.", tag: @tag}, status: :created
        else
            render json: {errors: @tag.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def tag_params
        params.require(:tag).permit(:name)
      end
end
