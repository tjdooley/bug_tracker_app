class DevelopersController < ApplicationController
  
  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(params[:developer])
    if @developer.save
      redirect_to @developer
    else
      render 'new'
    end
  end

  def show
    @developer = Developer.find(params[:id])
    @bugs = Bug.where(:developer_id => @developer.id)
  end

  def index
    @developers = Developer.paginate(:page => params[:page])
  end

  def destroy
    @developer = Developer.find(params[:id])
    @developer.destroy
    flash[:success] = "Developer destroyed."
    redirect_to developers_path
  end

  def edit
    @developer = Developer.find(params[:id])
  end

  def update
    @developer = Developer.find(params[:id])
    if @developer.update_attributes(params[:developer])
      flash[:success] = "Developer updated."
      redirect_to @developer
    else
      render 'edit'
    end
  end

end
