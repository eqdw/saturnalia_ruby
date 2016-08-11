class CreatePairs < ActiveRecord::Migration
  def change
    create_table :pairs do |t|
      t.references :person_one
      t.references :person_two
      t.date :pairing_date

      t.timestamps null: false
    end
  end
end
