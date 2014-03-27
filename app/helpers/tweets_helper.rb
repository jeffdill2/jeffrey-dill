module TweetsHelper
	def tweet_text(tweet)
		hshParsedTweet = JSON.parse(tweet.to_json)
		strTweetParsedText = hshParsedTweet['text']

		strTweetModifiedText = ""
		strTweetUser = ""
		strTweetHashtag = ""
		iTweetLength = strTweetParsedText.length
		iCharCount = 0
		bolUserFound = false
		bolHashtagFound = false

		strTweetParsedText.each_char do |char|
			iCharCount += 1

			if (char == "@" || bolUserFound) then
				bolUserFound = true

				if (!valid_user_or_hashtag_character(char)) then
					strTweetModifiedText = strTweetModifiedText + "<a href='http://www.twitter.com/" + strTweetUser + "' target='_blank'>" + strTweetUser + "</a>"
					strTweetUser = ""
					bolUserFound = false

					strTweetModifiedText = strTweetModifiedText + char
				else
					strTweetUser = strTweetUser + char

					if (iCharCount == iTweetLength) then
						strTweetModifiedText = strTweetModifiedText + "<a href='http://www.twitter.com/" + strTweetUser + "' target='_blank'>" + strTweetUser + "</a>"
					end
				end
			elsif (char == "#" || bolHashtagFound) then
				bolHashtagFound = true

				if (!valid_user_or_hashtag_character(char)) then
					strTweetModifiedText = strTweetModifiedText + "<a href='http://www.twitter.com/search?q=%23" + strTweetHashtag.sub("#", "") + "&src=hash' target='_blank'>" + strTweetHashtag + "</a>"
					strTweetHashtag = ""
					bolHashtagFound = false

					strTweetModifiedText = strTweetModifiedText + char
				else
					strTweetHashtag = strTweetHashtag + char

					if (iCharCount == iTweetLength) then
						strTweetModifiedText = strTweetModifiedText + "<a href='http://www.twitter.com/search?q=%23" + strTweetHashtag.sub("#", "") + "&src=hash' target='_blank'>" + strTweetHashtag + "</a>"
					end
				end
			else
				strTweetModifiedText = strTweetModifiedText + char
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

	def valid_user_or_hashtag_character(char)
		valid = 
		case char.bytes[0]
			when 48..57
				true
			when 64..90
				true
			when 97..122
				true
			when 35
				true
			when 95
				true
			else
				false
		end
	end
end