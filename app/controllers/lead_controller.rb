class LeadController < ApplicationController
  def index
  end

  def new
  end

  def show
    @lead = Lead.find(params[:id])
    @selected_tags_id = [1, 2]

    @collaterals = Collateral.includes(:tags).where(tags: {id: @selected_tags_id})
    # @collaterals = Collateral.joins(:tags).where(tags: {id: @selected_tags_id}).uniq
  end

end
