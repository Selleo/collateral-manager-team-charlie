class FilterCollateralByTagsQuery
  def initialize(tags)
    @tags = tags
  end

  def result
    Collateral.includes(collaterals_tags: :tag).where(collaterals_tags: {tag_id: @tags}).map do |collateral|
      { collateral: collateral, weight: collateral.collaterals_tags.sum do |collateral_tag| 
        ((@tags.reverse.index(collateral_tag.tag_id).to_f + 1).to_f / @tags.length.to_f) * collateral_tag.weight
        end
      }
    end.sort_by { |k| k[:weight] }.reverse
  end
end