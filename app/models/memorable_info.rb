class MemorableInfo < ActiveRecord::Base

	def display
		self.subject + "  --  " + self.description + "  --  " + self.image + "  --  " + self.date.to_s
	end

end
