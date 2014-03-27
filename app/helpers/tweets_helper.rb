module TweetsHelper
	def tweet_text(tweet)
		hshParsedTweet = JSON.parse(tweet.to_json)

		strTweetParsedText = hshParsedTweet['text']
		strTweetModifiedText = ""
		strTweetUser = ""
		bolUserFound = false

		strTweetParsedText.each_char do |char|
			strTweetCharacter = strTweetParsedText[char]

			if (strTweetCharacter == "@" || bolUserFound) then
				bolUserFound = true

				if (strTweetCharacter == " ") then
					bolUserFound = false
					strTweetModifiedText = strTweetModifiedText + "<a href='http://www.twitter.com/" + strTweetUser[1..-1] + "' target='_blank'>" + strTweetUser + "</a> "
				else
					strTweetUser = strTweetUser + strTweetCharacter
				end
			else
				strTweetModifiedText = strTweetModifiedText + strTweetCharacter
			end
		end

		strTweetModifiedText.html_safe
	end

	def tweet_url(tweet)
		hshParsedTweet = JSON.parse(tweet.to_json)

		if (defined? hshParsedTweet['entities']['media'][0]['media_url_https']) == nil
			nil
		else
			hshParsedTweet['entities']['media'][0]['media_url_https']
		end
	end
end