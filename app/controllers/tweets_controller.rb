class TweetsController < ApplicationController
	def index
		@tweets = Twitter.user_timeline(:count => 200, :include_entities => true)
	end
end
