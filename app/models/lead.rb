class Lead < ApplicationRecord
  has_many :leads_tags
  has_many :tags, through: :leads_tags
end
