require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
  end

  test "login with invalid info" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {email: "", password: "asdf"}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert_not flash.empty?
  end

  test "login with valid info and then logout" do
    get login_path
    post login_path, session: {email: @user.email, password: 'asdfasdf'}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', signup_path, count: 0
    assert_select 'a[href=?]', logout_path, count: 1
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path
    follow_redirect!
    assert_select 'a[href=?]', login_path, count: 1
    assert_select 'a[href=?]', signup_path, count: 1
    assert_select 'a[href=?]', logout_path, count: 0
  end

  test "login with remember me should make remember token" do
    log_in_as(@user, remember_me: 1)
    assert_not_nil cookies['remember_token']
  end

  test "login without remember me shouldn't make remember token" do
    log_in_as(@user, remember_me: 0)
    assert_nil cookies['remember_token']
  end
end
