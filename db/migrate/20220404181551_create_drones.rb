class CreateDrones < ActiveRecord::Migration[6.1]
  def change
    create_table :drones do |t|
      t.references :drone_type, null: false, foreign_key: true
      t.string :name, null: false
      t.string :faa_registration_number, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
