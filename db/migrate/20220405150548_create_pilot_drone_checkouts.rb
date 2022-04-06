class CreatePilotDroneCheckouts < ActiveRecord::Migration[6.1]
  def change
    create_table :pilot_drone_checkouts do |t|
      t.references :pilot, null: false, foreign_key: true
      t.references :drone, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
