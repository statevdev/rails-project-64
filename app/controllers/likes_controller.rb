class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    unless @post.likes.exists?(user_id: current_user.id)
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to @post
  end

  def destroy
    @like = @post.likes.find_by(user_id: current_user.id)
    @like&.destroy
    redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
