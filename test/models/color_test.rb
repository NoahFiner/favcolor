require 'test_helper'

class ColorTest < ActiveSupport::TestCase
  def setup
    @user = users(:user1)
    @color = @user.colors.build(hex: '000000', description: 'this is a sick color')
  end

  test "color should be valid" do
    assert @color.valid?
  end

  test "color should have a user id" do
    @color.user_id = nil
    assert_not @color.valid?
  end

  test "color should exist" do
    @color.hex = nil
    assert_not @color.valid?
  end

  test "color should be only 6 characters" do
    @color.hex = "aaaaa"
    assert_not @color.valid?
    @color.hex = "aaaaaaa"
    assert_not @color.valid?
  end

  test "color shouldn't have a hashtag" do
    @color.hex = '#aaaaaa'
    assert_not @color.valid?
  end

  test "color should be a valid hex code" do
    @color.hex = "eoisui"
    assert_not @color.valid?
    @color.hex = "aaaaaa"
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
