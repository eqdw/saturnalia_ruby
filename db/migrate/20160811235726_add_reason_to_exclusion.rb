class AddReasonToExclusion < ActiveRecord::Migration
  def change
    change_table :exclusions do |t|
      t.string :reason
    end
  end
end
