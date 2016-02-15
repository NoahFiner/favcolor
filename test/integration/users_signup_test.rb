require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "signup with invalid info doesn't make new user" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, user: {
        name: "Example Man",
        email: "invalid@example",
        password: "asdfasdf",
        password_confirmation: "asdfasdf" }
    end
    assert_template 'users/new'
  end

  test "valid info signup with activation" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, user: { name: "Example Man",
                              email: "valid@example.com",
                              password: "asdfasdf",
                              password_confirmation: "asdfasdf" }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    log_in_as(user)
    assert_not is_logged_in?
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    get edit_account_activation_path(user.activation_token, email: "wrong")
    assert_not is_logged_in?
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
