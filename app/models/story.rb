class Story < ApplicationRecord
  validates :title, presence: true, length: { maximum: 110 }
  validates :url, presence: true
end
