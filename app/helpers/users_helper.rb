module UsersHelper
  # Returns the gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = generate_gravatar_id(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def generate_gravatar_id(email)
    Digest::MD5::hexdigest(email)
  end
end
