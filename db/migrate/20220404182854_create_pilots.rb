class CreatePilots < ActiveRecord::Migration[6.1]
  def change
    create_table :pilots do |t|
      t.string :name, null: false
      t.integer :license_type, null: false

      t.timestamps
    end
  end
end
