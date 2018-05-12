module ApplicationHelper
  # 根据所在的页面返回完整的标题
  def full_title(page_title = '')
    base_title = "News"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end