# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_one)
  end

  test '#create' do
    sign_in @user
    @post = posts(:two)

    post post_likes_path(@post), params: { user_id: @user.id }

    assert_response :redirect

    created_like = PostLike.find_by(user_id: @user.id)

    assert created_like
  end

  test '#destroy' do
    sign_in @user
    @post = posts(:one)
    @like = post_likes(:one)

    delete post_like_path(@post, @like), params: { user_id: @user.id }

    assert_response :redirect
    assert_nil PostLike.find_by(user_id: @user.id)
  end
end
