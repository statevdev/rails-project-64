# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User', inverse_of: :posts
  belongs_to :category, dependent: :destroy

  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes, class_name: 'PostLike', dependent: :destroy

  validates :category_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
end
