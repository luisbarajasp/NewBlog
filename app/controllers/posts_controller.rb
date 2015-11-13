class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.all.order("created_at DESC").paginate(page: params[:page], per_page: 3)
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new post_params

		if @post.save
			redirect_to @post, notice: "Articulo guardado satisfactoriamente"
		else
			render 'new', notice: "Error: no se pudo guardar"
		end
	end

	def show

	end

	def edit
	end

	def update
		respond_to do |f|
			if @post.update(post_params)
				f.html {redirect_to @post, notice: "Tu artículo se guardo satisfactoriamente con el nuevo material"}
				f.json { render :show, status: :ok, location: @post }
			else
				f.html { render :edit }
				f.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@post.destroy
		redirect_to posts_path
	end

	def should_generate_new_friedly_id?
   		slug.blank? || title_changed?
	end

	private

		def post_params
			params.require(:post).permit( :image, :title, :content, :slug)
		end
		def find_post
			@post = Post.friendly.find(params[:id])
		end
end
