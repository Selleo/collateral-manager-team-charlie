class Collateral < ApplicationRecord
  has_one :collaterals_tag
  has_many :tags, through: :collaterals_tag
end
