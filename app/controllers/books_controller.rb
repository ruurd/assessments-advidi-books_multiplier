# encoding: UTF-8
#============================================================================
# (c) 2013 Bureau Pels. All Rights Reserved
#============================================================================
require 'open-uri'

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
		query = Settings.googlebooks.query
		startIndex = Settings.googlebooks.start_index.to_i
		maxResults = Settings.googlebooks.max_results.to_i

		begin
			done = false
			while not done
				parsed_json = GoogleBooksApiClient.load_page(query, startIndex, maxResults)
				if parsed_json
					items = parsed_json['items']
					if items && items.size > 0
						convert_json_to_books(parsed_json)
						if items.size < maxResults
							done = true
						else
							startIndex += maxResults
						end
					else
						done = true
					end
				end
			end
		rescue Exception => e
			logger.error(e.message)
		end
		redirect_to action: 'index'
	end

	private
	# Pick apart the JSON and fill the books table with it
	# @param parsed_json the parsed JSON to interpret
	def convert_json_to_books(parsed_json)
		items = parsed_json['items']
		items.each do |item|
			book = Book.where(:google_books_id => item['id']).first
			if book == nil
				book = Book.new
				book.google_books_id = item['id']
			end
			idents = item['volumeInfo']['industryIdentifiers']
			if idents && idents.size > 0
				idents.each do |type, identifier|
					if type == 'ISBN_13'
						book.isbn_13 = identifier
					end
				end
			end
			authors = item['volumeInfo']['authors']
			if authors and authors.size > 0
				book.author = authors[0]
			end
			book.title = item['volumeInfo']['title']
			book.thumbnail = item['volumeInfo']['previewLink']
			book.save
		end
	end

	def sort_column
		Book.column_names.include?(params[:sort]) ? params[:sort] : "id"
	end
end
