class CommentsController < ApplicationController
  COMM_NUM = 3

  def newcomments
    @newest_comments = Comment.order(created_at: :desc).limit(COMM_NUM)
  end

  def create
    @school_news = Schoolnews.find(params[:schoolnews_id])

    if @school_news.comments.create(comment_params)
      flash[:success] = "Comment Success!"
      redirect_to newcomments_path
    else
      render 'schoolnews/show'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :author)
    end

end
