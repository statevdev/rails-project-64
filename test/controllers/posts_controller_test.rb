# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @locale = { locale: I18n.default_locale }
  end

  test 'should get new' do
    sign_in users(:user_one)

    get new_post_path(@locale)
    assert_response :success
  end

  test 'should create post' do
    sign_in users(:user_one)

    assert_difference('Post.count') do
      post posts_path(@locale), params: {
        post: {
          title: @post.title,
          body: @post.body,
          category_id: @post.category_id,
          creator_id: @post.creator_id
        }
      }
    end

    assert_redirected_to post_path(Post.last, @locale)
  end

  test 'should get index' do
    get posts_path(@locale)
    assert_response :success
  end

  test 'should show post' do
    get post_path(@post, @locale)
    assert_response :success
  end
end
