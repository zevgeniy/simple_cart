module SimpleCart
  class CartItem < ::ActiveRecord::Base

    belongs_to :cart
    belongs_to :cartable, :polymorphic => true
    delegate :shopper, :to => :cart

    after_update :check_quantity

    scope :by_cartable, lambda { |cartable| where({:cartable_type => cartable.class.to_s, :cartable_id => cartable.id })}
    scope :by_cart, lambda {|cart| where({:cart_id => cart.id})}

    def total_price
      self.cartable.cartable_price * quantity
    end

    protected

    def check_quantity
      self.destroy if self.quantity < 1
    end
  end
end