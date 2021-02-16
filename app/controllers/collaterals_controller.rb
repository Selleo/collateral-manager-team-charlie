require 'collateral_decorator'
require 'json'

class CollateralsController < ApplicationController
  def index
    @collaterals = CollateralDecorator.decorate_collection(Collateral.all)
  end

  def show
    @collateral = Collateral.find(params[:id])
  end

  def new
    @collateral = Collateral.new
    @all_tags = Tag.all
  end

  def add_tags(added_tags)
    added_tags.each do |tag|
      begin
        @existing_tag = Tag.find(tag['id'])
        CollateralsTag.create({ tag_id: @existing_tag['id'],
                                collateral_id: @collateral['id'],
                                weight: tag['weight'] }).save
      rescue ActiveRecord::RecordNotFound
        @new_tag = Tag.create(name: tag['id'])
        @new_tag.save
        CollateralsTag.create({ tag_id: @new_tag['id'],
                                collateral_id: @collateral['id'],
                                weight: tag['weight'] }).save
      end
    end
  end

  def remove_tags(removed_tags)
    removed_tags.each do |tag|
      @collateral_tag = CollateralsTag.joins(:tag).where('tags.id = ?', tag).first
      CollateralsTag.destroy(@collateral_tag['id'])
    end
  end

  def create
    @collateral = Collateral.new(collateral_params)
    @collateral_created = @collateral.save
    if @collateral_created
      @added_tags = JSON.parse(params['added_tags'].gsub('\"', '"').gsub('/', ''))
      add_tags(@added_tags)
      redirect_to "/collaterals/#{@collateral.id}"
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
    @collateral = Collateral.find(params[:id])
    @all_tags = Tag.all
    @tags = Tag.joins(:collaterals_tags).where('collaterals_tags.collateral_id = ?', @collateral.id)
  end

  def update
    @collateral = Collateral.find(params[:id])
    if @collateral.update(collateral_params)  
      @added_tags = JSON.parse(params['added_tags'].gsub('\"', '"').gsub('/', ''))
      @removed_tags = JSON.parse(params['removed_tags'].gsub('\"', '"').gsub('/', ''))
      add_tags(@added_tags)
      remove_tags(@removed_tags)
      redirect_to @collateral
    else
      render :edit, status: :unprocessable_entity
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
