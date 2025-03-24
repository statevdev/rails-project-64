# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_one)
  end

  test '#create' do
    sign_in @user
    @post = posts(:two)

    assert_difference('PostLike.count', 1) do
      post post_likes_path(@post), params: { user_id: @user.id }
    end
  end

  test '#destroy' do
    sign_in @user
    @post = posts(:one)
    @like = post_likes(:one)

    assert_difference('PostLike.count', -1) do
      delete post_like_path(@post, @like), params: { user_id: @user.id }
    end
  end
end
