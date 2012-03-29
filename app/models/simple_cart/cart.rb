module SimpleCart
  class Cart < ::ActiveRecord::Base

    belongs_to :shopper, polymorphic: true
    has_many :cart_items, dependent: :destroy
    accepts_nested_attributes_for :cart_items

    def self.default_state
      :active
    end

    scope :by_default_state, where(:state => default_state)

    state_machine :state, :initial => :active do
      state :active, :processing, :failure, :success, :expired

      event :checkout do
        transition [:active, :failure] => :processing
      end

      event :succeeded do
        transition :processing => :success
      end

      event :failed do
        transition :processing => :failure
      end

      event :expire do
        transition :active => :expired
      end

      after_transition :on => :succeeded, :do => :on_success
      after_transition :on => :checkout, :do => :on_checkout
      after_transition :on => :failed, :do => :on_failed
      after_transition :on => :expire, :do => :on_expire
    end

    def on_checkout
      if SimpleCart.on_checkout_method.is_a?(Proc)
        SimpleCart.on_checkout_method.call(self)
      end
    end

    def on_success
      if SimpleCart.on_success_method.is_a?(Proc)
        SimpleCart.on_success_method.call(self)
      end
    end

    def on_failed
      if SimpleCart.on_failed_method.is_a?(Proc)
        SimpleCart.on_failed_method.call(self)
      end
    end

    def on_expire
      if SimpleCart.on_expire_method.is_a?(Proc)
        SimpleCart.on_expire_method.call(self)
      end
    end

    def in_cart?(cartable)
      cart_items.by_cartable(cartable).blank?
    end

    def add_item(cartable, quantity = 1)
      existing_cart_item = cart_items.by_cartable(cartable).first
      if existing_cart_item.blank?
        cart_items.create!(cartable: cartable, quantity: quantity)
      else
        existing_cart_item.quantity += quantity
        existing_cart_item.save!
        existing_cart_item
      end
    end

    def total
      cart_items.reload.map.sum(&:total_price)
    end

    def empty?
      cart_items.blank?
    end

    def count
      cart_items.reload.map.sum(&:quantity)
    end
  end
end