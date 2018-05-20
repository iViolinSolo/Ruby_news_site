require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path,  params: { user: { name:  "",
                                          email: "user@invalid",
                                          password:              "foo",
                                          password_confirmation: "bar" } }
    end
    assert_template 'sessions/new'

    # assert_select 'div#<CSS id for error explanation>'
    # assert_select 'div.<CSS class for field with error>'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "ViolinSolo6374",
                                         email: "user@example.com",
                                         password:              "foobar1@FOOBAR",
                                         password_confirmation: "foobar1@FOOBAR" } }
    end
    follow_redirect!
    assert_template 'schoolnews/index'
    assert_not flash.empty?
    assert flash[:success] == "Welcome to the School News App!"
  end
end
