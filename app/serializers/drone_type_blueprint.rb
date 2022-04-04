# frozen_string_literal: true

class DroneTypeBlueprint < Blueprinter::Base
  identifier :id

  fields :manufacturer, :model, :wing_type
end
