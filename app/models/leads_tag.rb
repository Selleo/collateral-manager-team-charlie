class LeadsTag < ApplicationRecord
    belongs_to :lead
    belongs_to :tag
end
  