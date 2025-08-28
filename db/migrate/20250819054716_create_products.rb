class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.references :store, null: false, foreign_key: true
      t.string :name
      t.string :product_code
      t.decimal :price
      t.integer :stock

      t.timestamps
    end
    add_index :products, :product_code, unique: true
  end
end
