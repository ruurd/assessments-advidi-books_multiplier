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
      start_index = Settings.googlebooks.start_index.to_i
      max_results = Settings.googlebooks.max_results.to_i

      done = false
      until done
        parsed_json = GoogleBooksApiClient.load_page(query,
                                                     start_index,
                                                     max_results)
        if parsed_json
          items = parsed_json['items']
          if items && items.size > 0
            convert_json_to_books(parsed_json)
            if items.size < max_results
              done = true
            else
              start_index += max_results
            end
          else
            done = true
          end
        else
          done = true
        end
      end
    rescue Exception => e
      puts e.message
    end
  end

  handle_asynchronously :load_all_job

  private

  # Pick apart the JSON and fill the books table with it
  # @param parsed_json the parsed JSON to interpre
  def convert_json_to_books(parsed_json)
    items = parsed_json['items']
    items.each do |item|
      book = Book.where(google_books_id: item['id']).first
      if book == nil
        book = Book.new
        book.google_books_id = item['id']
      end

      book.isbn_13 = nil
      idents = item['volumeInfo']['industryIdentifiers']
      if idents && idents.size > 0
        idents.each do |type, identifier|
          book.isbn_13 = identifier if type == 'ISBN_13'
        end
      end

      book.author = nil
      authors = item['volumeInfo']['authors']
      book.author = authors[0] if authors and authors.size > 0

      book.title = item['volumeInfo']['title']

      book.thumbnail = nil
      imagelinks = item['volumeInfo']['imageLinks']
      if imagelinks && imagelinks.size > 0
        imagelinks.each do |type, link|
          book.thumbnail = link if type == 'thumbnail'
        end
      end

      book.preview = item['volumeInfo']['previewLink']

      book.save
    end
  end

end
