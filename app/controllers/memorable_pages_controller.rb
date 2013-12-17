class MemorablePagesController < ApplicationController

	def index
		#incoming_url = request.referer
		#encoded_url = URI.encode(incoming_url)
		#@incoming_url_params = CGI.parse(URI.parse(incoming_url).query)
		#@incoming_url_params = URI.parse(encoded_url)

		@memories = MemorableInfo.all
	end
	
end
