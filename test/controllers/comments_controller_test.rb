# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_one)
    @post = posts(:one)
    @comment = post_comments(:one)
  end

  test 'should create root comment without nested comments' do
    sign_in @user

    comment_attrs = post_comments(:one).slice(:content, :ancestry)

    assert_difference('PostComment.count', 1) do
      post post_comments_path(@post), params: { post_comment: comment_attrs }
    end

    new_comment = PostComment.last

    assert_redirected_to post_path(@post)
    assert { new_comment.depth.zero? }
  end

  test 'should create root comment with nested comments' do
    sign_in @user

    assert_difference('PostComment.count', 1) do
      post post_comments_path(@post), params: {
        post_comment: {
          content: @comment.content,
          parent_id: @comment.id
        }
      }
    end

    reply = PostComment.last

    assert { @comment.id == reply.parent_id }
    assert_redirected_to post_path(@post)
  end
end
