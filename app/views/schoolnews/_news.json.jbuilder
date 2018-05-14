json.by news.author
json.id news.id
json.comments news.comments do |comment|
  json.partial! "comments/comment", comment: comment
end
json.time news.created_at.to_i
json.title news.title
json.type "news"
json.url news.source