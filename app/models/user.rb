class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: 'creator_id', dependent: :destroy, inverse_of: :creator
  has_many :post_comments, foreign_key: 'creator_id', dependent: :destroy, inverse_of: :creator
end
