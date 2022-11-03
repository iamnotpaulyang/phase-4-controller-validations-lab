class PostsController < ApplicationController
  #rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  #rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  # ^ why don't we need them? also not needed in private?
  
  def show
    post = Post.find(params[:id])
    render json: post
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    render json: post
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end

end
