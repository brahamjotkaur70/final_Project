class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    order  = Order.new(total_price: params[:cart_total])

    if order.save
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, error: order.errors.full_messages.first
    end
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    session[:cart_id] = nil
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_total, # in cents
      description: "Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_total,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )
    cart.each do |product_id, details|
      if product = Product.find_by(id: product_id)
        quantity = details['quantity'].to_i
        order.line_items.new(
          product: product,
          quantity: quantity,
          item_price: product.price,
          total_price: product.price * quantity
        )
      end
    end
    order.save!
    order
  end

  # returns total in cents not dollars (stripe uses cents as well)
  def cart_total
    total = 0
    cart.each do |product_id, details|
      if p = Product.find_by(id: product_id)
        total += p.price_cents * details['quantity'].to_i
      end
    end
    total
  end

end
