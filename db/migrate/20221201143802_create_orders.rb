class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :order_number
      t.decimal :order_price, precision: 7, scale: 2
      t.timestamps
    end
  end
end
