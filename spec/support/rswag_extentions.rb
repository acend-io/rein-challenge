# frozen_string_literal: true

module RswagExtentions
  SCHEMA_ROOT = Rails.root.join('spec/schema')

  def collection_for(resource_name)
    {
      type: 'array',
      description: "Array of #{resource_name.capitalize}s",
      items: {
        type: 'object',
        '$ref': "#/components/schemas/#{resource_name}"
      }
    }
  end

  def resource_schema(resource_name)
    JSON.parse(File.read(SCHEMA_ROOT.join("#{resource_name}.json")))
  end
end
