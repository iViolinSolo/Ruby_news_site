class SchoolnewsController < ApplicationController
  before_action :logged_in_user, only: [:new, :show, :create]

  PAGE_NUM = 8

  def index
    @page_num = params[:p]
    @page_num = 0 if @page_num.nil?
    @page_num = @page_num.to_i

    # puts @page_num
    # render plain: @page_num
    @news_list = Schoolnews.order(created_at: :desc).offset(@page_num * PAGE_NUM).limit(PAGE_NUM)
    # puts @news_list
    # render plain: @news_list.length
  end

  def show
    @school_news = Schoolnews.find(params[:id])
  end

  def new
    @school_news = Schoolnews.new
  end

  def create
    @school_news = Schoolnews.new(school_news_params)
    if @school_news.save
      # 处理注册成功的情况
      flash[:success] = "Successfully sbumit a news"
      redirect_to schoolnews_index_path
    else
      render 'new'
    end
  end

  private

    def school_news_params
      params.require(:schoolnews).permit(:title, :source, :author)
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
