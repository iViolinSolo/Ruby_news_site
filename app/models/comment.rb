class Comment < ApplicationRecord
  belongs_to :schoolnews
  validates :content, presence: true, length: {maximum: 3000, minimum: 3}
  validates :author, presence: true
end
