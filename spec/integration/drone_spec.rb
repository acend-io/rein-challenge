# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Drones API' do
  path '/drones' do
    get 'Get Drones' do
      tags 'Drone'
      produces 'application/json'

      response '200', 'Drone Index' do
        before do
          FactoryBot.create(:drone)
        end

        schema '$ref': '#/components/schemas/drone_collection'
        run_test!
      end
    end

    post 'Create Drone' do
      tags 'Drone'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :drone, in: :body, schema: { '$ref': '#/components/schemas/drone' }

      response '201', 'Create Drone - Success' do
        let(:drone_type) { FactoryBot.create(:drone_type) }
        let(:drone) { { drone: FactoryBot.attributes_for(:drone, drone_type_id: drone_type.id) } }

        schema '$ref': '#/components/schemas/drone'
        run_test!
      end

      response '400', 'Create Drone - Error' do
        let(:drone_type) { FactoryBot.create(:drone_type) }
        let(:drone) { { drone: FactoryBot.attributes_for(:drone, name: nil, drone_type_id: drone_type.id) } }

        schema '$ref': '#/components/schemas/errors'
        run_test!
      end
    end
  end

  path '/drones/{id}' do
    get 'GET Drone' do
      tags 'Drone'
      produces 'application/json'
      parameter name: :id, in: :path, type: :number

      response '200', 'Drone' do
        let(:id) { FactoryBot.create(:drone).id }

        schema '$ref': '#/components/schemas/drone'
        run_test!
      end

      response '404', 'Drone - Not Found' do
        let(:id) { -1 }
        run_test!
      end
    end
  end
end
