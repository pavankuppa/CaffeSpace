class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.string :name
      t.string :offer_type
      t.integer :discount_percentage
      t.timestamps
    end
  end
end
