class LeadsController < ApplicationController
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
    @specific_tags = [1]
    Collateral.includes(collaterals_tags: :tag).where(collaterals_tags: {tag_id: @specific_tags}).map do |collateral|
      { collateral: collateral, weight: collateral.collaterals_tags.sum do |collateral_tag| 
        ((@specific_tags.reverse.index(collateral_tag.tag_id) + 1).to_f / @specific_tags.length.to_f) * collateral_tag.weight
        end
      }
    end.sort_by { |k| - k[:weight] }

  end

end


# Collateral.includes(collaterals_tags: :tag).where(collaterals_tags: {tag_id: @specific_tags}).map {|a| 1}



# working one
    # Collateral.includes(collaterals_tags: :tag).where(collaterals_tags: {tag_id: @specific_tags})
    #   .map {
    #     |collateral| collateral.collaterals_tags
    #       .map { 
    #         |collateral_tag| ((@specific_tags.reverse.index(collateral_tag.tag_id) + 1).to_f / @specific_tags.length.to_f) * collateral_tag.weight
    #       }.sum
    #   }


    # Collateral.includes(collaterals_tags: :tag).where(collaterals_tags: {tag_id: @specific_tags}).map do |collateral|
    #   { collateral: collateral, weight: collateral.collaterals_tags.sum do |collateral_tag| 
    #     ((@specific_tags.reverse.index(collateral_tag.tag_id) + 1).to_f / @specific_tags.length.to_f) * collateral_tag.weight
    #     end
    #   }
    # end.sort_by! { |k| k[:weight] * -1 }
