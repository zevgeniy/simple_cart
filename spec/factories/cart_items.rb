FactoryGirl.define do
  factory :cart_item do
    cart {|a| a.association(:cart) }
    cartable {|a| a.association(:product) }
  end
end