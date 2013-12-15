require "CGI"
require "uri"

class MemorablePagesController < ApplicationController

	def index
<<<<<<< HEAD
		incoming_url = request.referer
		encoded_url = URI.encode(incoming_url)
		#@incoming_url_params = CGI.parse(URI.parse(incoming_url).query)
		@incoming_url_params = URI.parse(encoded_url)

		@memories = MemorableInfo.all
	end
=======
>>>>>>> parent of 56387f1... Created the table for the Memorable page

	end
	
end
