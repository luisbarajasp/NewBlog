class UsersController < ApplicationController
  def index
  	@users = User.all
  end
  
  def show
  	@user = User.find(params[:id])
    @posts = @user.posts.order("created_at DESC").paginate(page: params[:page], per_page: 10)

  	respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @user }
    end
  end
end
