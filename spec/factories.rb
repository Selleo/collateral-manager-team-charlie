FactoryBot.define do
  factory :lead do
    name { "MyString" }
  end

  factory :collaterals_tag do
    collateral_id { nil }
    tag_id { nil }
  end

  factory :tag do
    name { "MyString" }
  end

  factory :collateral do
    name { "MyString" }
    description { "MyString" }
    url { "MyString" }
    collateral_type { "MyString" }
  end

  factory :user do
    
  end

end
