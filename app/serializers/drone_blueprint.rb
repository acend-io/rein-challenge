# frozen_string_literal: true

class DroneBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :faa_registration_number, :drone_type_id
end
