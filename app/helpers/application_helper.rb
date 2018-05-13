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

  def cal_time_before(dt)
    puts dt
    origin = dt.to_i
    # puts origin
    now = Time.now.to_i

    difference = now - origin
    one_minute = 60
    one_hour = 60 * 60
    one_day = 60 * 60 * 24
    one_year = 60 * 60 * 24 * 365

    if difference < one_minute
      pluralize(difference, 'second')
    elsif one_minute <= difference && difference < one_hour
      pluralize(difference / one_minute, 'minute')
    elsif one_hour <= difference && difference < one_day
      pluralize(difference / one_hour, 'hour')
    elsif one_day <= difference && difference < one_year
      pluralize(difference / one_day, 'day')
    elsif one_year <= difference
      pluralize(difference / one_year, 'year')
    end
  end
end
