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

	def show
		@book = Book.find(params[:id])
	end

	def load
		require 'open-uri'
		query = 'ruby+on+rails'
		startIndex = 0
		maxResults = 40

		load_page_from_google_books(query, startIndex, maxResults)

		#while load_page_from_google_books(query, startIndex, maxResults) > 0
			# *** NOP ***
		#end

		redirect_to action: 'index'
	end

	private
	def load_page_from_google_books(query, start, maxresults)
		uri = URI.parse("https://www.googleapis.com/books/v1/volumes")

		params = {}
		params['q'] = query
		params['startIndex'] = start
		params['maxResults'] = maxresults

		uri.query = params.to_query

		jsoncontent = open(uri).read
		parsed_json = ActiveSupport::JSON.decode(jsoncontent)
		items = parsed_json['items']
		items.each do |item|
			book = Book.where(:google_book_id => item['id']).first
			if book == nil
				book = Book.new
				book.google_book_id = item['id']
			end
			idents = item['volumeInfo']['industryIdentifiers']
			idents.each do |type, identifier|
				if type == 'ISBN_13'
					book.isbn_13 = identifier
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
		items.size
	end

	def sort_column
		Announcement.column_names.include?(params[:sort]) ? params[:sort] : "id"
	end
end
