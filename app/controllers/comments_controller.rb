class CommentsController < ApplicationController
  COMM_NUM = 3

  def newcomments
    @news_list = Comment.order(created_at: :desc).limit(COMM_NUM)
  end
end
