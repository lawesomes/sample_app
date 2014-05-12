class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  #call back - to save ensure email is saved as lowercase

  before_create :create_remember_token 

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	#/ start of regex
		#\a match staart of string 
		#[\w+\-.]+ - at least one word character, plus, hypen or a dot
		#@ literal 
		#[a=z\d\-.]+ - at least one letter, digit, hyphen or do 
		#\. literal dot
		#[a-z]+ at least one letter 
		#\z - match end of string 
		#/end og regex
		#i case insensitive

  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  #also need to enforce uniqueness at database level 

  has_secure_password
  #implements password hashing -> needs password digest

  validates :password, length: { minimum: 6 }

  def User.new_remember_token 
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
   def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
      #call back - needs self, otherwise it will create a local var not an object instance attri
    end

end
