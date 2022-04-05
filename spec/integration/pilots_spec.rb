# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Pilots API' do
  path '/pilots' do
    get 'Get Pilots' do
      tags 'Pilot'
      produces 'application/json'

      response '200', 'Pilot Index' do
        before do
          FactoryBot.create(:pilot)
        end

        schema '$ref': '#/components/schemas/pilot_collection'
        run_test!
      end
    end

    post 'Create Pilot' do
      tags 'Pilot'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :pilot, in: :body, schema: { '$ref': '#/components/schemas/pilot' }

      response '201', 'Create Pilot - Success' do
        let(:pilot) { { pilot: FactoryBot.attributes_for(:pilot) } }
        schema '$ref': '#/components/schemas/pilot'
        run_test!
      end

      response '400', 'Create Pilot - Error' do
        let(:pilot) { { pilot: FactoryBot.attributes_for(:pilot, name: nil) } }
        schema '$ref': '#/components/schemas/errors'
        run_test!
      end
    end
  end

  path '/pilots/{id}' do
    get 'GET Pilot' do
      tags 'Pilot'
      produces 'application/json'
      parameter name: :id, in: :path, type: :number

      response '200', 'Pilot' do
        let(:id) { FactoryBot.create(:pilot).id }

        schema '$ref': '#/components/schemas/pilot'
        run_test!
      end

      response '404', 'Pilot - Not Found' do
        let(:id) { -1 }
        run_test!
      end
    end
  end
end
