require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:user1)
    @user2 = users(:user2)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect when not logged in on edit page" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect when not logged in on update page" do
    get :update, id: @user, user: {name: @user.name, email: @user.email}
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect edit when wrong user" do
    log_in_as(@user2)
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to user_path(@user2)
  end

  test "should redirect update when wrong user" do
    log_in_as(@user2)
    get :update, id: @user, user: {name: @user.name, email: @user.email}
    assert_not flash.empty?
    assert_redirected_to user_path(@user2)
  end

  test "should redirect destroy when user isn't logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when user isn't admin" do
    log_in_as(@user2)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to users_url
  end

end
