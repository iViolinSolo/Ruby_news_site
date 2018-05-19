class Comment < ApplicationRecord
  belongs_to :schoolnews

  VALID_CONTENT_REGEX = /\A\s*\S\s*\S\s*\S\s*/x
  validates :content, presence: true, length: {maximum: 1000, minimum: 3},
            format: { with: VALID_CONTENT_REGEX }
  validates :author, presence: true
end
