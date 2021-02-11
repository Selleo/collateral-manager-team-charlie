class CollateralsController < ApplicationController
  def index
    @collaterals = Collateral.all
  end

  def show
    @collateral = Collateral.find(params[:id])
  end

  def new
    @collateral_types = {
      0 => 'Article',
      1 => 'Video',
      2 => 'Podcast',
      3 =>  'Design',
     }

    @collateral = Collateral.new()
    @tags = Tag.all
  end

  def create
    @collateral = Collateral.new()
    @collateral.name = params[:name]
    @collateral.description = params[:description]
    @collateral.url = params[:url]
    @collateral.url = params[:collateral_type]

    if @collateral.save 
      redirect_to "/collaterals/#{@collateral.id}"
    else
      render "new"
    end
  end

  def edit

  end

  def destroy
    Collateral.destroy(params[:id])
  end
end
