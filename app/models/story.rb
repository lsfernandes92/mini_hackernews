class Story < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true, length: { maximum: 110 }
  validates :url, presence: true

  def url_host
    URI("#{self.url}").host || "unknown"
  end

  def all_comments
    parent_comments + child_comments
  end

    private
    
    def parent_comments
      Comment.where(commentable_id: id)
    end

    def child_comments
      Comment.where(commentable_id: parent_comments.map(&:id))
    end
end
