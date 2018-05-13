require 'test_helper'

class SchoolnewsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get schoolnews_new_url
    assert_response :success
  end

end
