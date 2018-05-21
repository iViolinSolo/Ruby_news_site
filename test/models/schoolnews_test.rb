require 'test_helper'

class SchoolnewsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  def setup
    @news_no_origin = Schoolnews.new(title: "Harry Potter present ", source: nil, author: "Alex")
    @news = Schoolnews.new(title: "Harry Potter present ", source: "http://baidu.com/s/S3wdDcew2f4F", author: "Alex")
  end

  test "should be valid" do
    assert @news.valid?
    assert @news_no_origin.valid?
  end

  test "title should be present" do
    @news.title = "     "
    assert_not @news.valid?
  end

  test "title should not be too long" do
    @news.title = "a" * 233
    assert_not @news.valid?
  end

  test "source can be empty" do
    @news.source = ""
    assert @news.valid?
    @news.source = "      "
    assert @news.valid?
    @news.source = nil
    assert @news.valid?
  end

  test "source should match the regex" do
    @news.source = "httpwww.baidu.com/sss"
    assert_not @news.valid?
    @news.source = "//www.baidu.com/sss"
    assert_not @news.valid?
    @news.source = "tp://www.baidu.com/sss"
    assert_not @news.valid?
  end
end
