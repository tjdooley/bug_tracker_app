#Controller that manages actions involving developers
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
    if @developer.destroyed?
      flash[:success] = "Developer destroyed."
      redirect_to developers_path
    else
      flash[:error] = "Developer could not be destroyed since they have assigned bugs."
      redirect_to developer_path(@developer)
    end
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
