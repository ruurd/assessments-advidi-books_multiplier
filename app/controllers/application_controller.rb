# encoding: UTF-8
#============================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
#============================================================================

#----------------------------------------------------------------------------
# Application controller base class
#
# TODO: document this class
#
class ApplicationController < ActionController::Base
	before_filter :set_locale
	protect_from_forgery

	def default_url_options(options={})
		options.merge({:locale => I18n.locale, :protocol => Settings.protocol})
	end

	def waypoint
		session[:waypoint] || root_path
	end

	def set_waypoint
		session[:waypoint] = request.referer
	end

	def lasttab(namespace)
		session["tab_#{namespace}"]
	end

	def set_lasttab(namespace, last_tab)
		session["tab_#{namespace}"] = last_tab
		lasttab("tab_#{namespace}")
	end

	def change_locale
		if Settings.translations.application.include?(params[:new_locale])
			I18n.locale = params[:new_locale]
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
