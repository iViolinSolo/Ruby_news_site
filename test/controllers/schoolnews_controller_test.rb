require 'test_helper'

class SchoolnewsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get schoolnews_new_url
    # assert_response :success
    # you need to login before go to this url
    assert_redirected_to login_url
  end

end
