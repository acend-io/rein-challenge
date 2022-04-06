class AddDateUniquenessIndexToPilotDroneCheckout < ActiveRecord::Migration[6.1]
  def change
    add_index :pilot_drone_checkouts, [:date, :pilot_id, :drone_id], unique: true
  end
end
