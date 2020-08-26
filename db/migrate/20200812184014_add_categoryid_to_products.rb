class AddCategoryidToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :categories, index: true, foreign_key: true

  end
end
