# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Drone Type API' do
  path '/drone_types' do
    get 'Get Drone Types' do
      tags 'Drone Type'
      produces 'application/json'

      response '200', 'Drone Type Index' do
        before do
          FactoryBot.create(:drone_type)
        end

        schema '$ref': '#/components/schemas/drone_type_collection'
        run_test!
      end
    end

    post 'Create Drone Type' do
      tags 'Drone Type'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :drone_type, in: :body, schema: { '$ref': '#/components/schemas/drone_type' }

      response '201', 'Create Drone Type - Success' do
        let(:drone_type) { { drone_type: FactoryBot.attributes_for(:drone_type) } }

        schema '$ref': '#/components/schemas/drone_type'
        run_test!
      end

      response '400', 'Create Drone Type - Error' do
        let(:drone_type) { { drone_type: FactoryBot.attributes_for(:drone_type, model: nil) } }

        schema '$ref': '#/components/schemas/errors'
        run_test!
      end
    end
  end

  path '/drone_types/{id}' do
    get 'GET Drone Type' do
      tags 'Drone Type'
      produces 'application/json'
      parameter name: :id, in: :path, type: :number

      response '200', 'Drone Type' do
        let(:id) { FactoryBot.create(:drone_type).id }

        schema '$ref': '#/components/schemas/drone_type'
        run_test!
      end

      response '404', 'Drone Type - Not Found' do
        let(:id) { -1 }
        run_test!
      end
    end
  end
end
