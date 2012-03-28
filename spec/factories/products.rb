FactoryGirl.define do
  sequence :title do |n|
     "Title #{n}"
  end

  factory :product do
    title { FactoryGirl.generate(:title) }
    price { 1.0 + rand(100) }
  end
end