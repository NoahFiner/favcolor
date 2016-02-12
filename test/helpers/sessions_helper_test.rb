require 'test_helper'
class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:user1)
    remember(@user)
  end

  test "current user returns correctly when session is nil" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "current user should be nil when remember token is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end

end
