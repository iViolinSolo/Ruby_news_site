class SchoolnewsController < ApplicationController
  before_action :logged_in_user, only: [:new, :show, :create]
  skip_before_action :verify_authenticity_token, only: [:create_json]

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
    @comment = Comment.new
  end

  def show_json
    @school_news = Schoolnews.find_by(id: params[:id])
    # @comment = Comment.new

    respond_to do |format|
      if @school_news.nil?
        msg = { :Error => "News with id:#{params[:id]} can not be found" }
        format.json { render json: msg, status: :not_found }
      else
        format.json { render :show, status: :ok }
      end
    end
  end

  def new
    @school_news = Schoolnews.new
  end

  # if @user.save
  #   format.html { redirect_to @user, notice: 'User was successfully created.' }
  #   format.json { render :show, status: :created, location: @user }
  # else
  #   format.html { render :new }
  #   format.json { render json: @user.errors, status: :unprocessable_entity }
  # end
  #
  # if @school_news.save
  #   # 处理注册成功的情况
  #   flash[:success] = "Successfully sbumit a news"
  #   redirect_to schoolnews_index_path
  # else
  #   render 'new'
  # end
  def create
    @school_news = Schoolnews.new(school_news_params)

    respond_to do |format|
      if @school_news.save
        # 处理注册成功的情况
        format.html {
          flash[:success] = "Successfully sbumit a news"
          redirect_to schoolnews_index_path
        }
        format.json { render :show, status: :created, location: @school_news }
      else
        format.html { render 'new' }
        format.json { render json: @school_news.errors, status: :unprocessable_entity}
      end
    end
  end

  def create_json
    candidate_params = item_create_param
    puts(candidate_params)

    if candidate_params[:type] == "news"
      puts "news-----"
      news_params = { :title => candidate_params[:text],
                      :source => candidate_params[:source],
                      :author => candidate_params[:username] }
      @school_news = Schoolnews.new(news_params)
      respond_to do |format|
        if @school_news.save
          # render json: @school_news
          format.json { render :show, status: :created, location: @school_news }
        else
          # render json: @school_news.errors
          format.json { render json: @school_news.errors, status: :unprocessable_entity}
        end
      end
    elsif candidate_params[:type] == "comments"
      puts "comment-----"
      commnet_params = { :content => candidate_params[:text],
                         :author => candidate_params[:username],
                         :schoolnews_id => candidate_params[:news_id] }
      @comment = Comment.new(commnet_params)
      respond_to do |format|
        if @comment.save
          # render json: @comment
          format.json { render "comments/show", status: :created, location: @comment }
        else
          # render json: @comment
          format.json { render json: @comment.errors, status: :unprocessable_entity}
        end
      end
    else
      respond_to do |format|
        msg = { :Error => "type:#{candidate_params[:type]} not support" }
        format.json { render json: msg, status: :not_acceptable}
      end
    end

    # return
    # @school_news = Schoolnews.new(school_news_params)
    # respond_to do |format|
    #   if @school_news.save
    #     # render json: @school_news
    #     format.json { render :show, status: :created, location: @school_news }
    #   else
    #     # render json: @school_news.errors
    #     format.json { render json: @school_news.errors, status: :unprocessable_entity}
    #   end
    # end
  end

  private

    def school_news_params
      params.require(:schoolnews).permit(:title, :source, :author)
    end

    def item_create_param
      params.permit(:username, :text, :type, :source, :news_id)
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
