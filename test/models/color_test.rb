require 'test_helper'

class ColorTest < ActiveSupport::TestCase
  def setup
    @user = users(:user1)
    @color = @user.colors.build(color: '000000', description: 'this is a sick color')
  end

  test "color should be valid" do
    assert @color.valid?
  end

  test "color should have a user id" do
    @color.user_id = nil
    assert_not @color.valid?
  end

  test "color should exist" do
    @color.color = nil
    assert_not @color.valid?
  end

  test "color should be only 6 characters" do
    @color.color = "aaaaa"
    assert_not @color.valid?
    @color.color = "aaaaaaa"
    assert_not @color.valid?
  end

  test "color shouldn't have a hashtag" do
    @color.color = '#aaaaaa'
    assert_not @color.valid?
  end

  test "color should be a valid hex code" do
    @color.color = "eoisui"
    assert_not @color.valid?
    @color.color = "aaaaaa"
    assert @color.valid?
  end

  test "description shouldn't be over 100 characters" do
    @color.description = "a" * 101
    assert_not @color.valid?
  end

  test "order should be most recent first" do
    assert_equal colors(:color4), Color.first
  end
end
