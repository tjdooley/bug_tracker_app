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

end
