class RemoveAndAddCategoryIdToProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :categories_id, :integer
    add_column :products, :category_id, :integer
  end
end
