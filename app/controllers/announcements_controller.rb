# encoding: UTF-8
#============================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
#============================================================================

#----------------------------------------------------------------------------
# Announcement CRUD controller
#
class AnnouncementsController < ApplicationController
	before_filter :authenticate_user!
	helper_method :sort_column, :sort_direction

	def index
		@announcements = Announcement.search(params[:search]).order(sort_specification).page(params[:page])
	end

	def show
		@announcement = Announcement.find(params[:id])
	end

	def new
		@announcement = Announcement.new
	end

	def edit
		@announcement = Announcement.find(params[:id])
	end

	def create
		@announcement = Announcement.new(params[:announcement])

		if @announcement.save
			redirect_to @announcement, notice: 'Announcement was successfully created.'
		else
			render action: "new"
		end
	end

	def update
		@announcement = Announcement.find(params[:id])
		if @announcement.update_attributes(params[:announcement])
			redirect_to @announcement, notice: 'Announcement was successfully updated.'
		else
			render action: "edit"
		end
	end

	def destroy
		@announcement = Announcement.find(params[:id])
		@announcement.destroy
		redirect_to announcements_url
	end

	private
	def sort_column
		Announcement.column_names.include?(params[:sort]) ? params[:sort] : "id"
	end

end
