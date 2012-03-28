module SimpleCart
  class CartsController < ApplicationController

    before_filter :find_cart

    def show
      @cart_items = @cart.cart_items
    end

    def update
      if @cart.update_attributes(params[:simple_cart_cart])
        flash[:notice] = "Cart updated"
        redirect_to simple_cart_cart_path
      else
        render :show
      end
    end

    private

    def find_cart
      @cart = current_cart
    end
  end
end