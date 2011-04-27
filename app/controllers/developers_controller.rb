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

end
