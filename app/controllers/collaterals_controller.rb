class CollateralsController < ApplicationController
  def index
    @collaterals = Collateral.all
  end

  def show
    @collateral = Collateral.find(params[:id])
  end

  def new
    @collateral = Collateral.new()
    @tags = Tag.all
  end

  def edit

  end

  def destroy
    Collateral.destroy(params[:id])
  end
end
