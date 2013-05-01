# encoding: UTF-8
#============================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
#============================================================================

#-----------------------------------------------------------------------------
# Announcement
#
class Book < ActiveRecord::Base

	def to_s
		title
	end


	def self.search(search)
		if search
			where('message LIKE :msg', msg: "%#{search}%")
		else
			scoped
		end
	end
end
