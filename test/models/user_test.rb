require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: "ViolinSolo4894", email: "33f@le.com", password: "foobar1@FOOBAR", password_confirmation: "foobar1@FOOBAR")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "email should match the regex" do
    @user.email = "sd.com"
    assert_not @user.valid?
    @user.email = "sd@com"
    assert_not @user.valid?
    @user.email = "@ss.com"
    assert_not @user.valid?
  end


  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "password should match the regex" do
    @user.password = @user.password_confirmation = "Ab@foobarfoobar"
    assert_not @user.valid?
    @user.password = @user.password_confirmation = "Ab1foobarfoobar"
    assert_not @user.valid?
    @user.password = @user.password_confirmation = "ab1@foobarfoobar"
    assert_not @user.valid?
    @user.password = @user.password_confirmation = "AB1@FOOBARFOOBAR"
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end
end
