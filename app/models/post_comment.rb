class PostComment < ApplicationRecord
  has_ancestry
  belongs_to :post
  belongs_to :user, inverse_of: :comments
end
