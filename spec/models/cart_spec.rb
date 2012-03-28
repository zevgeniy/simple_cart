require 'spec_helper'

describe SimpleCart::Cart do

  let(:cart)      {create(:cart)}
  let(:product)   {create(:product)}
  let(:products)  {[create(:product), create(:product), create(:product)]}

  it { should belong_to(:shopper) }
  it { should have_many(:cart_items) }

  before do
    Product.acts_as_cartable
  end

  it "should have 'active' state by default" do
    cart.should be_active
  end

  describe "adding to a cart" do
    it "should be empty" do
      cart.should be_empty
    end

    it "should increment cart items by one" do
      proc{ cart.add_item(product) }.should change(cart.cart_items, :count).by(1)
    end

    context "adding existing item" do
      before do
        cart.add_item(product)
      end

      it "should not increment cart items by one" do
        proc{ cart.add_item(product) }.should_not change(cart.cart_items, :count)
      end

      it "should increment quantity into cart item by one" do
        cart.add_item(product)
        cart_item = cart.cart_items.by_cartable(product).first
        cart_item.quantity.should == 2
      end
    end
  end

  context ".total" do
    it "should return total price of the cart" do
      products.each {|p| cart.add_item(p)}
      sum = products.inject(0){|sum,p| sum + p.price }
      cart.total.should == sum
    end
  end
end