class CategoriesController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def index
    @categories = Category.all.order("category ASC")
  end

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

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    respond_to do |f|
      if @category.update(category_params)
        f.html {redirect_to categories_path, notice: "Tu liga se guardo satisfactoriamente con el nuevo material"}
        f.json { render :show, status: :ok, location: @category }
      else
        f.html { render :edit }
        f.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.present?
      @category.destroy
    end
    redirect_to categories_path
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
