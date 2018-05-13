class Schoolnews < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum: 10, maximum: 200}

  VALID_URL_REGEX = /(https?|ftp|file):\/\/[-A-Za-z0-9+&@#\/%?=~_|!:,.;]+[-A-Za-z0-9+&@#\/%=~_|]/i
  validates :source, format: {with: VALID_URL_REGEX, on: :create}, allow_nil: true, allow_blank: true  # Allow nil but if not empty, match regex
end
