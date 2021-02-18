class LeadController < ApplicationController
  def index
    @all_tags = Tag.all
  end

  def search_collaterals_by_tags
        
  end
  def get_collaterals
    tags = params["tags"]
    puts tags.to_a
    if tags != nil
      array_of_tags = tags.map(&:to_i)
      founded_collaterlas = FilterCollateralByTagsQuery.new(array_of_tags).result
      puts founded_collaterlas
      render json: founded_collaterlas
    end
  end
end