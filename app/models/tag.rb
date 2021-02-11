class Tag < ApplicationRecord
  has_many :collaterals, through: :collaterals_tags
end
