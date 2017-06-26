class Post < ActiveRecord::Base
  validates :title, :sub, :author, presence: true

  has_many :comments

  belongs_to :author,
  foreign_key: :user_id,
  class_name: :User

  belongs_to :sub

  def top_level_comments
    self.comments.where(parent_comment_id: nil)
  end

end
