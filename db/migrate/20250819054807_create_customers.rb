class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.references :store, null: false, foreign_key: true
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end
