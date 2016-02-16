require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:user1)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "favicolor account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_match user.name, mail.body.encoded
    assert_match user.activation_token, mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

  test "reset password" do
    user = users(:user1)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "favicolor password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_match user.name, mail.body.encoded
    assert_match user.reset_token, mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

end
