class LeadController < ApplicationController
  def index
  end

  def new
  end

  #function to show collaterals
  def show
    @lead = Lead.find(params[:id])
    # @selected_tags_id = [1, 2]

    @collaterals = collateral.all
    # @collaterals = Collateral.includes(:tags).where(tags: {id: @selected_tags_id})
  end

  #Function to show collaterals by specific tags, 
  #if user chooses tags [ruby, js] it will find only those, which contain at least [ruby,js] 
  def show_by_tags
    @specific_tags = [1,2,3,4]
    Collateral.joins(:tags).group(:id).having("array_agg(tags.id) @> ARRAY[" + specific_tags + "]::bigint[]")
  end

end
