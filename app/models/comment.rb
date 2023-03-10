class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :video
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: 'parent_id', dependent: :destroy
end
