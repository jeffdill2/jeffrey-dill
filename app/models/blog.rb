class Blog < ActiveRecord::Base
	def helper_string
		# "#{self.title}  --  #{self.article}  --  #{self.date}"
		self.title + "  --  " + self.article + "  --  " + self.date.to_s
	end
end
