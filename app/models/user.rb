# encoding: UTF-8
#============================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
#============================================================================

#-----------------------------------------------------------------------------
# User
#
class User < ActiveRecord::Base
	devise :database_authenticatable,
	       :registerable,
	       :recoverable,
	       :rememberable,
	       :trackable,
	       :validatable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :first_name,
					:last_name,
					:gender,
					:phone,
					:mobile,
					:im,
					:is_admin,
					:email,
					:password,
					:password_confirmation,
					:remember_me

	validates :email, :uniqueness => true

	# Use full name as stringform
	def to_s
		"#{first_name} #{last_name}"
	end

	# Is this user an admin (STUB)
	def admin?
		true
	end

	# Send welcome message
	def welcome
		WelcomeMailSender.perform_async(id)
	end

	# Search in the person table
	def self.search(search)
		if search
			where('email LIKE :srch', srch: "%#{search}%")
		else
			scoped
		end
	end

end
