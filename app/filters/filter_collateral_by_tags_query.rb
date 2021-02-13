class FilterCollateralByTagsQuery
  def initialize(tags)
    @tags = tags
  end

  def result
    return [Collateral.first]
  end
end