module SimpleCart
  module ActionController

    def self.included(base)
      unless base.included_modules.include?(InstanceMethods)
        base.extend ClassMethods
        base.send :include, InstanceMethods
      end
    end

    module InstanceMethods

      #extend ActiveSupport::Memoizable

      def self.included(base)
        base.send :helper_method, :current_cart
      end

      def current_cart
        cart = find_cart_by_session || Cart.create(:shopper => current_shopper)
        session[:cart_id] = cart.id
        cart
      end
      #memoize :current_cart

      def current_shopper
        self.respond_to?(SimpleCart.current_shopper_method) ? self.send(SimpleCart.current_shopper_method) : nil
      end

      protected

      def find_cartable(cartable_id = params[:cartable_id])
        @cartable = cartable_class.find_by_id(cartable_id)
      end

      def cartable_class(cartable_type = params[:cartable_type])
        cartable_type.capitalize.constantize
      end

      private

      def find_cart_by_session
        Cart.find_by_id(session[:cart_id])
      end

    end

    module ClassMethods

    end

  end
end

::ActionController::Base.send(:include, ::SimpleCart::ActionController)