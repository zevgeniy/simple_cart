require 'acceptance/acceptance_helper'

feature "Cart", %q{
  In order to make a purchase
  As an user
  I want to add products to cart and manage cart
} do

  scenario "Add product to cart" do
    visit products_path

  end

end