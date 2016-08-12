class MarkPairsAsCompleted < ActiveRecord::Migration
  def change
    change_table :pairs do |t|
      t.remove  :pairing_date
      t.boolean :active, default: false
    end
  end
end
