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
		strUserLinkRoot = "<a href='http://www.twitter.com/|USER|' target='_blank'>|USER|</a>"
		strHashtagLinkRoot = "<a href='http://www.twitter.com/search?q=%23|HASHTAG|&src=hash' target='_blank'>#|HASHTAG|</a>"

		strTweetParsedText.each_char do |char|
			iCharCount += 1

			if (char == "@" || bolUserFound) then
				bolUserFound = true

				if (!valid_user_or_hashtag_character(char)) then
					strTweetModifiedText = strTweetModifiedText + strUserLinkRoot.gsub("|USER|", strTweetUser)
					strTweetUser = ""
					bolUserFound = false

					strTweetModifiedText = strTweetModifiedText + char
				else
					strTweetUser = strTweetUser + char

					if (iCharCount == iTweetLength) then
						strTweetModifiedText = strTweetModifiedText + strUserLinkRoot.gsub("|USER|", strTweetUser)
					end
				end
			elsif (char == "#" || bolHashtagFound) then
				bolHashtagFound = true

				if (!valid_user_or_hashtag_character(char)) then
					strTweetModifiedText = strTweetModifiedText + strHashtagLinkRoot.gsub("|HASHTAG|", strTweetHashtag.sub("#", ""))
					strTweetHashtag = ""
					bolHashtagFound = false

					strTweetModifiedText = strTweetModifiedText + char
				else
					strTweetHashtag = strTweetHashtag + char

					if (iCharCount == iTweetLength) then
						strTweetModifiedText = strTweetModifiedText + strHashtagLinkRoot.gsub("|HASHTAG|", strTweetHashtag.sub("#", ""))
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