module UsersHelper
  def gravatar_for(user)
    email_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://secure.gravatar.com/avatar/#{email_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
