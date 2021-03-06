class Collateral < ApplicationRecord
  has_many :collaterals_tags
  has_many :tags, through: :collaterals_tags
  enum collateral_type: { article: 0, video: 1, podcast: 2, design: 3}
end
