class CreateExclusions < ActiveRecord::Migration
  def change
    create_table :exclusions do |t|
      t.references :person_one
      t.references :person_two

      t.timestamps null: false
    end
  end
end
