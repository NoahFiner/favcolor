require 'test_helper'

class ColorsControllerTest < ActionController::TestCase
  def setup
    @color = colors(:color1)
  end

  test "trying to create color when not logged in should redirect to login url" do
    assert_no_difference 'Color.count', 0 do
      post :create, color: {hex: @color.hex, description: @color.description}
    end
    assert_redirected_to login_url
  end

  test "trying to destroy color when not logged in should redirect to login url" do
    assert_no_difference 'Color.count', 0 do
      delete :destroy, id: @color
    end
    assert_redirected_to login_url
  end
end
