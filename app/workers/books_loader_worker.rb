# encoding: UTF-8
#============================================================================
# Copyright (c) Bureau Pels.  All Rights Reserved.
#============================================================================
require 'open-uri'

#----------------------------------------------------------------------------
# Worker that loads books from Google and puts them in the database
#
class BooksLoaderWorker
	# Load all books you can find about ruby on rails
	def load_all_job
		begin
			query = Settings.googlebooks.query
			startIndex = Settings.googlebooks.start_index.to_i
			maxResults = Settings.googlebooks.max_results.to_i

			done = false
			while not done
				Delayed::Worker.logger.add(Logger::INFO, "Loading #{query} from #{startIndex} for #{maxResults} books")
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
				else
					Delayed::Worker.logger.add(Logger::INFO, "No parsed JSON from Google alas, exiting")
					done = true
				end
			end
		rescue Exception => e
			Delayed::Worker.logger.add(Logger::ERROR, e.message)
		end
	end
	handle_asynchronously :load_all_job

	private

	# Pick apart the JSON and fill the books table with it
	# @param parsed_json the parsed JSON to interpre
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

			Delayed::Worker.logger.add(Logger::INFO, "Saving book #{book}")
		end
	end

end
