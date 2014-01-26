module ApplicationHelper
	def full_title(page_title)
		base_title = "Jeffrey Dill"

		if page_title.empty?
			base_title
		else
			"#{base_title}  |  #{page_	title}"
		end
	end
end