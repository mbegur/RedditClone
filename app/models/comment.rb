class Comment < ActiveRecord::Base
  validates :content, :author, :post, presence: true

  belongs_to :author,
  class_name: :User

  belongs_to :post

  has_many :child_comments,
  foreign_key: :parent_comment_id,
  class_name: :Comment

  belongs_to :parent_comment,
  foreign_key: :parent_comment_id,
  class_name: :Comment


end
