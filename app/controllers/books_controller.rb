# encoding: UTF-8
#============================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
#============================================================================

#-----------------------------------------------------------------------------
# Handle Book list
#
class BooksController < ApplicationController
	helper_method :sort_column, :sort_direction

	# Show the list of books, paginated.
	def index
		@books = Book.search(params[:search]).order(sort_specification).page(params[:page])
	end

	# Show a single book
	def show
		@book = Book.find(params[:id])
	end

	def come_back_later
	end

	# Load the list of books from the database
	def load
		query = params["q"]
		startIndex = params[:startIndex] ? params[:startIndex].to_i : 0
		maxResults = params[:maxResults] ? params[:startIndex].to_i : 10
		@count = Book.all.count
		@books = Book.offset(startIndex).limit(maxResults)
	end

	# Load ALL the books from Google
	def load_all
		::BooksLoaderWorker.new.load_all_job
		redirect_to action: 'come_back_later'
	end

	private
	def sort_column
		Book.column_names.include?(params[:sort]) ? params[:sort] : "id"
	end
end
