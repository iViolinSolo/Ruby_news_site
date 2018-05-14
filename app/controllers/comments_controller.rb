class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:new, :show, :create]

  COMM_NUM = 3

  def newcomments
    @newest_comments = Comment.order(created_at: :desc).limit(COMM_NUM)
  end

  def create
    # @school_news = Schoolnews.find(params[:schoolnews_id])

    # @comm = @school_news.comments.build
    @comm = Comment.new
    if @comm.save(comment_params)
      flash[:success] = "Comment Success!"
      redirect_to newcomments_path
    else
      flash.now[:danger] = "Invalid Comment Content!"
      render 'schoolnews/show'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :author, :schoolnews_id)
    end

    # 前置过滤器
    # 确保用户已登录
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

end
