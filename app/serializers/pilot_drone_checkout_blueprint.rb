# frozen_string_literal: true

class PilotDroneCheckoutBlueprint < Blueprinter::Base
  identifier :id

  fields :pilot_id, :drone_id, :date # Seems like we don't need them, probably makes sense to move it to a view
  association :pilot, blueprint: PilotBlueprint
  association :drone, blueprint: DroneBlueprint
end
