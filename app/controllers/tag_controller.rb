class TagController < ApplicationController
  def index
    
  end

  def new
    @CollateralsTag = CollateralsTag.new
  end

  def show
    @CollateralsTag = CollateralsTag.find(params[:id])
  end
end
