class PostComment < ApplicationRecord
  has_ancestry
  belongs_to :post
  belongs_to :creator, class_name: 'User', inverse_of: :comments
end
