class Schoolnews < ApplicationRecord
  has_many :comments, dependent: :destroy
  # validates
end
