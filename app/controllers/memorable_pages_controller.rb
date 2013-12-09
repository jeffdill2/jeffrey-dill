class MemorablePagesController < ApplicationController

	def index
		@memories = MemorableInfo.all
	end

	def memory_params
		params.require(:memory).permit(:subject, :description, :image, :date)
	end
	
end
