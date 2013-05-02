# encoding: UTF-8
#============================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
#============================================================================

#----------------------------------------------------------------------------
# Application controller base class
#
class ApplicationController < ActionController::Base
	before_filter :set_locale
	protect_from_forgery

	# Set default url options
	def default_url_options(options={})
		options.merge({:locale => I18n.locale, :protocol => Settings.protocol})
	end

	# Fetch the last rememebered waypoint in a screenflow
	def waypoint
		session[:waypoint] || root_path
	end

	# Remember the referer as waypoint so we can return to it later
	def set_waypoint
		session[:waypoint] = request.referer
	end

	# Change the locale of the application. Pick apart the request, then substitute
	# the locale in the request en redirect to the new version
	def change_locale
		if Settings.translations.application.include?(params[:new_locale])
			I18n.locale = params[:new_locale]
			session[:locale] = I18n.locale
			if request.referrer
				uri = request.referer.dup
				route = Rails.application.routes.recognize_path(uri)
				route[:locale] = params[:new_locale]
				redirect_to(url_for(route))
			else
				redirect_to(root_path)
			end
		end
	end

	# Remember locale in session. Determine from path or session or TLD or the default locale
	def set_locale
		I18n.locale = params[:locale] || session[:locale] || locale_from_tld || I18n.default_locale
		session[:locale] = I18n.locale
	end

	private
	def locale_from_tld
		parsed_locale = request.host.split('.').last
		Settings.translations.application.include?(parsed_locale.to_sym) ? parsed_locale : nil
	end

	def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end

	def sort_specification
		sort_column + ' ' + sort_direction
	end

end
