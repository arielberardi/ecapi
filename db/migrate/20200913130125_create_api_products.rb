class CreateApiProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false, index: true
      t.text :description
      t.float :price, null: false, default: 0
      t.float :discount, null: false, default: 0
      t.float :stock, null: false, default: 0
      t.references :category, null: false, foreign_key: true
      t.references :subcategory, null: false, foreign_key: true
      t.timestamps
    end
  end
end
