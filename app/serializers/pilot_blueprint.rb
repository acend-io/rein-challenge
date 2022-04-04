# frozen_string_literal: true

class PilotBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :license_type
end
