class Cart < ApplicationRecord
  has_many :line_items

  def add_product(product_params)
    current_item = line_items.find_by(product_id: product_params[:product_id])
    if current_item
      current_item.quantity += product_params[:quantity].to_i
    current_item.save
    else
    new_item = line_items.create(product_id: product_params[:product_id],
      quantity: 1,
      cart_id: self.id)
    end
    new_item
  end
end
