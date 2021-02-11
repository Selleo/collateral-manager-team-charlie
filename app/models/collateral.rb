class Collateral < ApplicationRecord
  has_many :tags, through: :collaterals_tag
end
