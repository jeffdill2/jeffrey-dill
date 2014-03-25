module TweetsHelper
	def tweet_text(tweet)
		hshParsedTweet = JSON.parse(tweet.to_json)

		hshParsedTweet['text']
	end

	def tweet_url(tweet)
		hshParsedTweet = JSON.parse(tweet.to_json)

		if (defined? hshParsedTweet['entities']['media'][0]['media_url_https']) == nil
			""
		else
			hshParsedTweet['entities']['media'][0]['media_url_https']
		end
	end
end