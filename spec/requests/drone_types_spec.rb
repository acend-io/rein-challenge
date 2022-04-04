# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DroneTypes', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create(:drone_type)
    end

    it 'returns an array of drone types' do
      get '/drone_types'

      response_json = JSON.parse(response.body)
      expect(response_json.length).to eq 1
    end
  end

  describe 'GET /show' do
    let(:drone_type) { FactoryBot.create(:drone_type) }

    it 'returns a drone type' do
      get "/drone_types/#{drone_type.id}"

      response_json = JSON.parse(response.body)
      %w[manufacturer model wing_type].each do |attribute|
        expect(response_json[attribute]).to eq(drone_type.send(attribute))
      end
    end
  end

  describe 'POST /create' do
    let(:response_json) { JSON.parse(response.body) }
    let(:request) { post '/drone_types', params: { drone_type: params } }

    context 'with valid params' do
      let(:params) { FactoryBot.attributes_for(:drone_type) }

      it 'responds with http status created' do
        request
        expect(response).to have_http_status(:created)
      end

      it 'responds with the created drone type' do
        request
        %w[manufacturer model wing_type].each do |attribute|
          expect(response_json[attribute]).to eq(params[attribute.to_sym].to_s)
        end
      end

      it 'creates a drone type in the database' do
        expect { request }.to change(DroneType, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:params) { { manufacturer: 'Manufacturer', model: nil, wing_type: 'fixed' } }

      it 'responds with http status bad request' do
        request
        expect(response).to have_http_status(:bad_request)
      end

      it 'responds with the errors' do
        request
        error_response = response_json.find { |field| field['attribute'] = 'model' }
        expect(error_response['type']).to eq('blank')
      end

      it 'does not create a drone type in the database' do
        expect { request }.not_to change(DroneType, :count)
      end
    end
  end
end
