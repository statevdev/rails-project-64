# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test 'should get new' do
    sign_in users(:user_one)

    get new_post_path
    assert_response :success
  end

  test 'should create post' do
    sign_in users(:user_one)

    post_params = {
      title: @post.title,
      body: @post.body,
      category_id: @post.category_id,
      creator_id: @post.creator_id
    }

    post posts_path, params: { post: post_params }

    assert_response :redirect

    created_post = Post.find_by(post_params)

    assert created_post
  end

  test 'should get index' do
    get posts_path
    assert_response :success
  end

  test 'should show post' do
    get post_path(@post)
    assert_response :success
  end
end
