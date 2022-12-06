class CreateVariants < ActiveRecord::Migration[7.0]
  def change
    create_table :variants do |t|
      t.references :item, null: false, foreign_key: true
      t.string :quantity
      t.decimal :price, precision: 7, scale: 2

      t.timestamps
    end
  end
end
