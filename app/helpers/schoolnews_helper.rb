module SchoolnewsHelper
  def news_has_source?(news)
    if news.source.nil? || news.source == ''
      false
    else
      true
    end
  end

  def safe_source(news)
    safe_res = ''
    if news.source.nil? or news.source == ''
      safe_res
    else
      '(' + URI(news.source).host + ')'
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
