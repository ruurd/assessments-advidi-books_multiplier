module GoogleBooksApiClient

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
	rescue
		nil
	end
end