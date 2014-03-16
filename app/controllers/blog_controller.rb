class BlogController < ApplicationController
	def create
		@blog = Blog.create( blog_params )

		if @blog.valid?
			redirect_to blog_index_path
		else
			render :new, :status => :unprocessable_entity
		end
	end

	def destroy
		Blog.destroy(params[:id])
		redirect_to blog_index_path
	end

	def edit
		@blog = Blog.find(params[:id])
	end

	def update
		@blog = Blog.find(params[:id])

		@blog.update_attributes( blog_params )

		if @blog.valid?
			redirect_to blog_index_path
		else
			render :edit, :status => :unprocessable_entity
		end
	end

	def new
		@blog = Blog.new
	end

	def index
		@blogs = Blog.all
	end

	def show
		@blog = Blog.find(params[:id])
	end

	private

	def blog_params
		params.require(:blog).permit(:title, :article, :date)
	end
end	