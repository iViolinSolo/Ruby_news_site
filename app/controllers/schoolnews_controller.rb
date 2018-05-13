class SchoolnewsController < ApplicationController
  PAGE_NUM = 8

  def index
    @page_num = params[:p]
    @page_num = 0 if @page_num.nil?
    # puts @page_num
    # render plain: @page_num
    @news_list = Schoolnews.order(created_at: :desc).offset(@page_num * PAGE_NUM).limit(PAGE_NUM)
    # puts @news_list
    # render plain: @news_list.length
  end

  def new

  end
end
