FactoryBot.define do
  factory :reservation do
    reserve_date { Time.now }
  end
end
