module SimpleCart
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      def self.source_root
        @source_root ||= File.expand_path("../../../../app/views/simple_cart", __FILE__)
      end

      def copy_views
        directory "carts", "app/views/simple_cart/carts"
        directory "cart_items", "app/views/simple_cart/cart_items"
      end
    end
  end
end