class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true

  has_many :posts

  belongs_to :moderator,
  foreign_key: :user_id,
  class_name: :User
end
