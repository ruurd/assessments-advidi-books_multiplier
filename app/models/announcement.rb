# encoding: UTF-8
#============================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
#============================================================================

#-----------------------------------------------------------------------------
# Announcement
#
class Announcement < ActiveRecord::Base
	validates_inclusion_of :level, :in => %w(success info warning error), :message => "%{value} must be success, info, warning or error"

	scope :current, where('starts_at <= now() AND ends_at >= now()')
	scope :local, where("locale = ?", I18n.locale)

	def self.search(search)
		if search
			where('message LIKE :msg', msg: "%#{search}%")
		else
			scoped
		end
	end

end
