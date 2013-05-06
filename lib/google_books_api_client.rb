# encoding: UTF-8
#============================================================================
# Copyright (c) Bureau Pels.  All Rights Reserved.
#============================================================================

#----------------------------------------------------------------------------
# A client that interrogates the Books API
#
module GoogleBooksApiClient

  # load max_query results from google starting at start_index
  # @param query query to run
  # @param start_index get results starting at
  # @param max_results this much results if available
  # @result a piece of decoded JSON
  def self.load_page(query, start_index, max_results)
    proto = Settings.googlebooks.protocol
    host = Settings.googlebooks.host
    path = Settings.googlebooks.path

    params = {}
    params['q'] = query
    params['startIndex'] = start_index
    params['maxResults'] = max_results
    qry = params.to_query

    url = "#{proto}://#{host}#{path}?#{qry}"

    jsoncontent = open(url).read
    ActiveSupport::JSON.decode(jsoncontent)
  end
end