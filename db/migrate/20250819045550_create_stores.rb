class CreateStores < ActiveRecord::Migration[8.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :store_id

      t.timestamps
    end
    add_index :stores, :store_id, unique: true
  end
end
