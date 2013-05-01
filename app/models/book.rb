# encoding: UTF-8
#============================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
#============================================================================

#-----------------------------------------------------------------------------
# Announcement
#
class Book < ActiveRecord::Base

	# Use the title for a stringified book
	def to_s
		title
	end

	# Search in the database
	def self.search(search)
		if search
			where('author LIKE :srch OR titel LIKE :srch', srch: "%#{search}%")
		else
			scoped
		end
	end
end
