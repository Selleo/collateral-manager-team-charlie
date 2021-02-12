class CollateralsController < ApplicationController
  def index
    @collaterals = Collateral.all
  end

  def show
    @collateral = Collateral.find(params[:id])
  end

  def new
    @collateral = Collateral.new
    @tags = Tag.all
  end

  def create
    @collateral = Collateral.new(collateral_params)
    if @collateral.save 
      redirect_to "/collaterals/#{@collateral.id}"
    else
      render "new"
    end
  end

  def edit
    @collateral = Collateral.find(params[:id])
  end

  def update
    @collateral = Collateral.find(params[:id])
  
    if @collateral.update(collateral_params)
      redirect_to @collateral
    else
      render "new"
    end
  end

  def destroy
    Collateral.destroy(params[:id])
    redirect_to "/collaterals"
  end

  def collateral_params
    params.require(:collateral).permit(:name, :description, :url, :collateral_type)
  end
end
