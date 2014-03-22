class BlogController < ApplicationController
	before_filter :authenticate, :except => [:index, :show]

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
		@blogs = Blog.all.order('created_at DESC')
	end

	def show
		@blog = Blog.find(params[:id])
	end

	private
	def blog_params
		params.require(:blog).permit(:title, :article, :date)
	end

	private
	def authenticate
		authenticate_or_request_with_http_basic do |name, password|
			name == "admin" && password == "admin"
		end
	end
end	