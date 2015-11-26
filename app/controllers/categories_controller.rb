class CategoriesController < ApplicationController
  def new
  	@category = Category.new
  end

  def create
  	@category = Category.new category_params

  	if @category.save
		redirect_to posts_path, notice: "Liga guardada satisfactoriamente"
	else
		render 'new', notice: "Error: no se pudo guardar"
	end
  end

  def show
  	@category = Category.find(params[:id])
    @posts = @category.posts.order("created_at DESC").paginate(page: params[:page], per_page: 10)
    @users = User.all
    @categories = Category.all.order("category ASC")
    
  	respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @category }
    end
  end

  private

  def category_params
  	params.require(:category).permit(:category)
  end
end
