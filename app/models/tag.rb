class Tag < ApplicationRecord
  has_many :leads_tags
  has_many :leads, through: :leads_tags
  has_many :collaterals_tags
  has_many :collaterals, through: :collaterals_tags
end
