class Collateral < ApplicationRecord
  has_many :collaterals_tags
  has_many :tags, through: :collaterals_tags
end
