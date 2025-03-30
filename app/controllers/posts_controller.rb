# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @posts = Post.includes(:category, :creator).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc)
    @likes = @post.likes
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post.id, locale: I18n.locale), notice: t('posts.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id, :creator_id)
  end
end
