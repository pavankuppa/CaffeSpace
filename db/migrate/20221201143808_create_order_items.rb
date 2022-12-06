class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.string :item_name, null: false, foreign_key: true
      t.string :offer_name
      t.string :offer_type
      t.boolean :free
      t.integer :discount_percentage
      t.string :quantity
      t.decimal :price, precision: 7, scale: 2
      t.timestamps
    end
  end
end
