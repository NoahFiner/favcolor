require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example Guy", email: "example@example.org",
                    password: "asdfasdf", password_confirmation: "asdfasdf")
  end

  test "user name should exist" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "user email should exist" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "user name shouldn't be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "user email shouldn't be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end

  test "user email should be valid" do
    valid_addresses = ["guy@guy.com", "hi+asdf@asdfFEW.com", "E_A_E@asdf.as.sdf"]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?
    end
  end

  test "user email shouldn't be invalid" do
    bad_addresses = ["no@no", "@asdf.com", "asdf@@@@@eee.com", "asdf@adsf,com"]
    bad_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?
    end
  end

  test "uniqueness" do
    dup_user = @user.dup
    dup_user.email.upcase!
    @user.save
    assert_not dup_user.valid?
  end

  test "password should be over 6 characters" do
    @user.password = @user.password_confirmation = "asdf"
    assert_not @user.valid?
  end

  test "password shouldn't be blank" do
    @user.password = @user.password_confirmation = "          "
    assert_not @user.valid?
  end

  test "password shouldn't be too long" do
    @user.password = @user.password_confirmation = "a" * 256
    assert_not @user.valid?
  end

  test "authenticated? should be false with no digest" do
    assert_not @user.authenticated?('')
  end

end
