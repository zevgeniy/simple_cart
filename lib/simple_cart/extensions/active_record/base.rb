module SimpleCart
  module ActiveRecord

    def self.included(base)
      unless base.included_modules.include?(InstanceMethods)
        base.extend ClassMethods
      end
    end

    module InstanceMethods
      def cartable_price
        if self.respond_to? simple_cart_value_by_key(:price).to_sym
          self.send(simple_cart_value_by_key(:price).to_sym)
        else
          simple_cart_value_by_key(:price)
        end
      end

      def cartable_title
        if self.respond_to? simple_cart_value_by_key(:title).to_sym
          self.send(simple_cart_value_by_key(:title).to_sym)
        else
          simple_cart_value_by_key(:title)
        end
      end

      def in_cart?(cart)
        cart.in_cart?(self)
      end

      private

      def simple_cart_value_by_key(key)
        self.class.simple_cart_config[key]
      end

    end

    module ClassMethods
      def acts_as_cartable(options = {})
        config = {price: "price", title: "title"}
        config.update(options) if options.is_a?(Hash)
        @simple_cart_config = config
        has_many :cart_items, as: :cartable
        register_cartable(self)
        include InstanceMethods
        true
      end

      def simple_cart_config
        @simple_cart_config ||= {}
      end

      protected

      def register_cartable(klass)
        SimpleCart.cartables = (SimpleCart.cartables << klass.name).uniq
      end
    end
  end
end

::ActiveRecord::Base.send(:include, ::SimpleCart::ActiveRecord)