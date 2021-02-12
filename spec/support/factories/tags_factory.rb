FactoryBot.define do
    factory :tag do |i|
      sequence(:name) { |j| "tag#{j}" }
    end
end
  