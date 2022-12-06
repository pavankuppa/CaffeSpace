class CreateOfferItems < ActiveRecord::Migration[7.0]
  def change
    create_table :offer_items do |t|
      t.references :offer
      t.references :variant, null: false, foreign_key: true
      t.boolean :free, default: false
      t.timestamps
    end
  end
end
