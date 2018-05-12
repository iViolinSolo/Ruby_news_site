class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {minimum: 5, maximum: 20},
            format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
end
