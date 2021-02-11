class Collateral < ApplicationRecord
  has_many :tags, through: :collaterals_tag
  enum collateral_type: [ :article, :video, :podcast, :design]
end
