# encoding: UTF-8
#============================================================================
# Copyright (c) Bureau Pels.  All Rights Reserved.
#============================================================================

#----------------------------------------------------------------------------
# Initialize pecunia
#

# Set host and protocol
ActionMailer::Base.default_url_options = {:host => Settings.host, :protocol => Settings.protocol}

# Set up smtp settings if any
if Settings['smtp_settings']
	smtp_settings = Hash.new
	Settings.smtp_settings.each do |k, v|
		smtp_settings[k.to_sym] = v
	end
	ActionMailer::Base.smtp_settings = smtp_settings
end
