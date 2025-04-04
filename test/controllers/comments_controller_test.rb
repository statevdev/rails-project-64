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

    comment_attrs = @comment.slice(:content, :ancestry)

    post post_comments_path(@post), params: { post_comment: comment_attrs }

    assert_redirected_to post_path(@post)

    new_comment = PostComment.find_by(comment_attrs)

    assert new_comment
    assert new_comment.depth.zero?
  end

  test 'should create root comment with nested comments' do
    sign_in @user

    comment_attrs = @comment.slice(:content, :ancestry)

    post post_comments_path(@post), params: { post_comment: comment_attrs }

    assert_redirected_to post_path(@post)

    new_comment = PostComment.find_by(comment_attrs)

    assert new_comment

    reply = new_comment.children.create!(content: @comment.content, user: @user, post: @post)

    assert { new_comment.id == reply.parent_id }
  end
end
