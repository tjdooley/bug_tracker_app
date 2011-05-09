#Controller that manages actions related to bugs
class BugsController < ApplicationController
  def new
    @bug = Bug.new
  end

  def create
    @bug = Bug.new(params[:bug])
    if @bug.save
      redirect_to @bug
    else
      render 'new'
    end
  end

  def show
    @bug = Bug.find(params[:id])
    @developer = Developer.find(@bug.developer_id)
  end

  def index
    @bugs = Bug.paginate(:page => params[:page])
  end

  def destroy
    @bug = Bug.find(params[:id])
    @bug.destroy
    flash[:success] = "Bug destroyed."
    redirect_to bugs_path
  end

  def edit
    @bug = Bug.find(params[:id])
  end

  def update
    @bug = Bug.find(params[:id])
    if @bug.update_attributes(params[:bug])
      flash[:success] = "Bug updated."
      redirect_to @bug
    else
      render 'edit'
    end
  end

end
