require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  def setup
    @news = Schoolnews.new(title: "Harry Potter present ", source: "http://baidu.com/s/S3wdDcew2f4F", author: "Alex")
    # puts(@news.id) if @news.save
    #
    # puts(@news.errors.full_messages)

    @comment = Comment.new(content: "Harry Potter present ", author: "Alex", schoolnews_id: @news.id)
  end

  test "should be valid" do
    assert @comment.valid?
    @comment.save

    puts(@comment.errors.full_messages)
  end

  test "content should be present" do
    @comment.content = "     "
    assert_not @comment.valid?
  end

  test "content should not be too long" do
    @comment.content = "a" * 23399
    assert_not @comment.valid?
  end

  test "content should match regex" do
    @comment.content = " s  3  "
    assert_not @comment.valid?
    @comment.content = "s3"
    assert_not @comment.valid?
  end

  test "author should be present" do
    @comment.author = "     "
    assert_not @comment.valid?
  end

end
