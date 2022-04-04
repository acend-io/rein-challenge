# frozen_string_literal: true

class ErrorBlueprint < Blueprinter::Base
  field :attribute
  field :full_message
  field :type
end
