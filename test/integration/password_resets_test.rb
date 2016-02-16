require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:user1)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    #invalid email
    post password_resets_path, password_reset: {email: ""}
    assert_not flash.empty?
    assert_template 'password_resets/new'
    #valid email
    post password_resets_path, password_reset: {email: @user.email}
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to root_url
    #password resets form
    user = assigns(:user)
    #uh oh wrong email again
    get edit_password_reset_path(user.reset_token, email: "invalid")
    assert_redirected_to root_url
    #inactive dude
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)
    #right email, wrong token
    get edit_password_reset_path("nope", email: user.email)
    assert_redirected_to root_url
    #everything's right now
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_select "input[name=email][type=hidden][value=?]", user.email
    #invalid password combination
    patch password_reset_path(user.reset_token), email: user.email,
          user: {password: "asdfasdf", password_confirmation: "fdasfdsa"}
    assert_select 'div#error-explanation'
    #finally right
    patch password_reset_path(user.reset_token), email: user.email,
          user: {password: "asdfasdf", password_confirmation: "asdfasdf"}
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end
end
