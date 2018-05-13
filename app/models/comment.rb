class Comment < ApplicationRecord
  belongs_to :schoolnews
  validates :content, presence: true
  validates :author, presence: true
end
