require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), user: {name: "joe", email: "no", password: "incorrect", password_confirmation: "incorrecto"}
    assert_template 'users/edit'
  end

  test "successful edit and friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "other name"
    email = "other_email@email.com"
    patch user_path(@user), user: {name: name, email: email, password: "asdfasdf", password_confirmation: "asdfasdf"}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
