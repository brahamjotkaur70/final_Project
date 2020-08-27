class ApplicationController < ActionController::Base
  

protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cart

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstname, :lastname, :email, :password)}
  end

  def set_cart
    @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def after_sign_in_path_for(resource_or_scope)
    products_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
