# encoding: UTF-8
#============================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
#============================================================================

#-----------------------------------------------------------------------------
# Handle About page
#
class BooksController < ApplicationController
	helper_method :sort_column, :sort_direction
	def index
		@books = Book.search(params[:search]).order(sort_specification).page(params[:page])
	end

	private
	def sort_column
		Announcement.column_names.include?(params[:sort]) ? params[:sort] : "id"
	end
end
