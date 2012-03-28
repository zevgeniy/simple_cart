FactoryGirl.define do
  factory :cart, :class => 'SimpleCart::Cart' do
    shopper {|a| a.association(:user) }
  end
end