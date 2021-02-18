FactoryBot.define do
  factory :collaterals_tag do
    collateral_id { nil }
    tag_id { nil }
    weight { 1 }
  end

  factory :lead do
    name { "MyString" }
  end

  factory :tag do
    name { "MyString" }
  end

  factory :collateral do
    name { "MyString" }
    description { "MyString" }
    url { "MyString" }
    collateral_type { "article" }
  end

  factory :user do
    email { "test@selleo.com" }
    password { "123456"}
  end

end
