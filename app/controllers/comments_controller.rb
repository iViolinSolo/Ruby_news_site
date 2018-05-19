class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:new, :show, :create]

  COMM_NUM = 3

  def newcomments
    @newest_comments = Comment.order(created_at: :desc).limit(COMM_NUM)
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def show_json
    @comment = Comment.find_by(id: params[:id])
    respond_to do |format|
      if @comment.nil?
        msg = { :Error => "Comment with id:#{params[:id]} can not be found" }
        format.json { render json: msg, status: :not_found }
      else
        format.json { render :show, status: :ok }
      end
    end
  end

  def create
    # @school_news = Schoolnews.find(params[:schoolnews_id])

    # @comm = @school_news.comments.build
    @comment = Comment.new(comment_params)
    # puts comment_params
    if @comment.save
      # puts "Succeed........."
      flash[:success] = "Comment Success!"
      redirect_to newcomments_path
    else
      # puts "Failure........."
      flash.now[:danger] = "Invalid Comment Content!"
      @school_news = Schoolnews.find(comment_params[:schoolnews_id])
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
