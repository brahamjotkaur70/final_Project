class ApplicationController < ActionController::Base
    # def cart
    #     # value = cookies[:cart] || JSON.generate({})
    #     @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
    # end
    # helper_method :cart
    #
    # def update_cart(new_cart)
    #   cookies[:cart] = {
    #     value: JSON.generate(new_cart),
    #     expires: 10.days.from_now
    #   }
    #   cookies[:cart]
    # end

  before_action :set_cart

  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end
