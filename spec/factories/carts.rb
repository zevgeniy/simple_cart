FactoryGirl.define do
  factory :cart do
    shopper {|a| a.association(:user) }
  end
end