class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.references :person

      t.string :name

      t.timestamps
    end
  end
end
