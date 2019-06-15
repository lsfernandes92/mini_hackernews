class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  validates :body, presence: true

  def root_story
    story = self
    story = story.commentable until story.commentable.is_a?(Story)
    story.commentable
  end
end
