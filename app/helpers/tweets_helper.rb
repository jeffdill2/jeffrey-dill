module TweetsHelper
	def tweet_text(tweet)
		hshParsedTweet = tweet_hash(tweet)
		strTweetParsedText = hshParsedTweet['text']
		strTweetModifiedTextPass1 = ""
		strTweetModifiedTextPass2 = ""
		strTweetUser = ""
		strTweetHashtag = ""
		iCharCount = 0
		iTweetLength = strTweetParsedText.length
		bolUserFound = false
		bolHashtagFound = false
		strUserColor = "#267DC0"
		strHashtagColor = "#208345"
		strURLColor = "#208345"
		strUserLinkRoot = "<a class='grow' href='http://www.twitter.com/|USER|' target='_blank'><span style='color: #{strUserColor};'>|USER|</span></a>"
		strHashtagLinkRoot = "<a class='grow' href='http://www.twitter.com/search?q=%23|HASHTAG|&src=hash' target='_blank'><span style='color: #{strHashtagColor};'>#|HASHTAG|</span></a>"
		strURLLinkRoot = "<a class='grow' href='|URL|' target='_blank'><span style='color: |URL_COLOR|;'>|URL|</span></a>"
		iURLStartIndex = 0
		iURLEndIndex = 0
		strParsedURL = ""

		strTweetModifiedTextPass1 = strTweetParsedText.gsub(/[[:space:]]/, " ")

		while true do
			iURLStartIndex = strTweetModifiedTextPass1.index("http", iURLEndIndex)

			if (iURLStartIndex == nil) then
				break
			end

			iURLEndIndex = strTweetModifiedTextPass1.index(" ", iURLStartIndex)

			if (iURLEndIndex == nil) then
				iURLEndIndex = iTweetLength
			end

			strParsedURL = strTweetModifiedTextPass1[iURLStartIndex..iURLEndIndex]
			strModifiedURL = strURLLinkRoot.gsub("|URL|", strParsedURL)
			strTweetModifiedTextPass1.sub!(strParsedURL, strModifiedURL)

			iURLReplacementLength = strModifiedURL.length
			iURLEndIndex = iURLStartIndex + iURLReplacementLength
			iTweetLength = strTweetModifiedTextPass1.length
		end

		strTweetModifiedTextPass1.each_char do |char|
			iCharCount += 1

			if (char == "@" || bolUserFound) then
				bolUserFound = true

				if (!valid_user_or_hashtag_character(char)) then
					strTweetModifiedTextPass2 = strTweetModifiedTextPass2 + strUserLinkRoot.gsub("|USER|", strTweetUser)
					strTweetUser = ""
					bolUserFound = false

					strTweetModifiedTextPass2 = strTweetModifiedTextPass2 + char
				else
					strTweetUser = strTweetUser + char

					if (iCharCount == iTweetLength) then
						strTweetModifiedTextPass2 = strTweetModifiedTextPass2 + strUserLinkRoot.gsub("|USER|", strTweetUser)
					end
				end
			elsif (char == "#" || bolHashtagFound) then
				bolHashtagFound = true

				if (!valid_user_or_hashtag_character(char)) then
					strTweetModifiedTextPass2 = strTweetModifiedTextPass2 + strHashtagLinkRoot.gsub("|HASHTAG|", strTweetHashtag.sub("#", ""))
					strTweetHashtag = ""
					bolHashtagFound = false

					strTweetModifiedTextPass2 = strTweetModifiedTextPass2 + char
				else
					strTweetHashtag = strTweetHashtag + char

					if (iCharCount == iTweetLength) then
						strTweetModifiedTextPass2 = strTweetModifiedTextPass2 + strHashtagLinkRoot.gsub("|HASHTAG|", strTweetHashtag.sub("#", ""))
					end
				end
			else
				strTweetModifiedTextPass2 = strTweetModifiedTextPass2 + char
			end
		end

		strTweetModifiedTextPass2.sub!("|URL_COLOR|", strUserColor)

		strTweetModifiedTextPass2.html_safe
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

	def tweet_url(tweet)
		hshParsedTweet = tweet_hash(tweet)

		if ((defined? hshParsedTweet['entities']['media'][0]['media_url_https']) == nil) then
			nil
		else
			hshParsedTweet['entities']['media'][0]['media_url_https']
		end
	end

	def tweet_id(tweet)
		tweet_hash(tweet)['id']
	end

	def tweet_hash(tweet)
		hshParsedTweet = JSON.parse(tweet.to_json)
	end
end