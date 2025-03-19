class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user
    @comment.parent_id = params[:parent_id] if params[:parent_id].present?

    if @comment.save
      redirect_to @post, notice: t('comments.created')
    else
      render 'posts/show', status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
