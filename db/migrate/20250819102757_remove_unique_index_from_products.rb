class RemoveUniqueIndexFromProducts < ActiveRecord::Migration[8.0]
  def change
    remove_index :products, :product_code
    add_index :products, [:store_id, :product_code], unique: true
  end
end
