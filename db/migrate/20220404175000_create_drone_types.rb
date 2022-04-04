class CreateDroneTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :drone_types do |t|
      t.string :manufacturer, null: false
      t.string :model, null: false
      t.integer :wing_type, null: false

      t.timestamps
    end
    add_index :drone_types, [:manufacturer, :model], unique: true, name: :drone_type_make_model
  end
end
