class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :item_name
      t.text :description
      t.integer :category_id
      t.integer :condition_id
      t.integer :shipping_cost_id
      t.integer :prefecture_id
      t.integer :shipping_day_id
      t.integer :price
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
