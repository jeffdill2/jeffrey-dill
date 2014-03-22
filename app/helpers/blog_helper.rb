module BlogHelper
	def recent_blog_posts_cache_key
		"recent-blogs-#{Blog.count}"
	end
end