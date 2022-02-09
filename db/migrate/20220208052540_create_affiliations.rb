class CreateAffiliations < ActiveRecord::Migration[7.0]
  def change
    create_table :affiliations do |t|
      t.references :person

      t.string :name

      t.timestamps
    end
  end
end
