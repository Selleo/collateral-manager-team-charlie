# example to use factorybot
FactoryBot.define do
    factory :collateral do |i|
      sequence(:name) { |i| "collateral#{i}" }
      description { "descirption aaa" }
      #type
      kind { "blog" } 
    end
end