class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.references :person

      t.string :suburb
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
