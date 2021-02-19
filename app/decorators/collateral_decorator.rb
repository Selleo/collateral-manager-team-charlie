class CollateralDecorator < Draper::Decorator
  delegate_all
  
  def tags
    Tag.joins(:collaterals_tags).where('collaterals_tags.collateral_id = ?', collateral.id).select('collaterals_tags.weight, tags.name')
  end
end
