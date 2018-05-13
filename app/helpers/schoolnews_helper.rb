module SchoolnewsHelper
  def safe_source(news)
    safe_res = ''
    if news.source.nil?
      safe_res
    else
      '(' + news.source + ')'
    end
  end

  def safe_comments_counts(news)
    comments = news.comments.all
    if comments.nil?
      0
    else
      comments.length
    end
  end
end
