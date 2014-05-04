class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  #call back - to save ensure email is saved as lowercase

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
  validates :password, length: { minimum: 6 }

end
