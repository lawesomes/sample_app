module SessionsHelper
	def sign_in (user)
		remember_token = User.new_remember_token
		#create new token - in the user model

		cookies.permanent[:remember_token] = remember_token 
		#place raw token in the browser cookies
		#permanent makes it set expiration to 20.years.from_now


		user.update_attribute(:remember_token, User.digest(remember_token))
		#save the hashed token to the database for the user 

		self.current_user = user 
		#set current_user to the given user (parameter user)
	end

	def current_user=(user) #equals indicates the method handles assignment to user object
		@current_user = user 
		#instance variable current user is set to the passed user (self)
		#converted - basically current_user(self)
	end

	def current_user 
		remember_token = User.digest(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
			#OR EQUALS assignment operator 
			#sets @current_user instance var to the user corresponding to the remember token, only if @current_user is undefined 
	end 

	def signed_in?
		!current_user.nil? 
	end 

	def sign_out
	    current_user.update_attribute(:remember_token,
	                                  User.digest(User.new_remember_token))
	    #change users remember token for security reason in the db
	    #basically creates new remember token via the method and stores


	    cookies.delete(:remember_token)
	    #invoke delete method on cookie 

	    self.current_user = nil
	    #sets user to nil - not really necessary because of immediate redirect in the destroy action
  	end
end
