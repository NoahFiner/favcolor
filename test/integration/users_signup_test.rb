require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
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

  test "signup with valid info should make a new user and log them in" do
    get signup_path
    assert_difference "User.count", 1 do
      post_via_redirect users_path, user: { name: "Example Man",
                              email: "valid@example.com",
                              password: "asdfasdf",
                              password_confirmation: "asdfasdf" }
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
end
