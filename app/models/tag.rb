class Tag < ApplicationRecord
  has_many :collaterals_tags
  has_many :collaterals, through: :collaterals_tags
end
