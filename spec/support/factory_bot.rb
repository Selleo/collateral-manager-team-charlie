FactoryBot.use_parent_strategy = true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

# # example to use factorybot
# FactoryBot.define do
#   factory :collateral do |i|
#     sequence(:name) { |i| "collateral#{i}" }
#     description { "descirption aaa" }
#     #type
#     kind { } 
#   end
# end


create(:collateral)