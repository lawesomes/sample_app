module UsersHelper

	def gravatar_for (user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
			#API makes the ID an MD5 hash of the email
   		gravatar_url = "https://secure.gravatar.com/avatar/" + gravatar_id
    	image_tag(gravatar_url, alt: user.name, class: "gravatar")
    	#output image_tag function -> renders an  <IMG>
	end
end
