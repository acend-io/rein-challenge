# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Drones', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create(:drone)
    end

    it 'returns an array of drones' do
      get '/drones'

      response_json = JSON.parse(response.body)
      expect(response_json.length).to eq 1
    end
  end

  describe 'GET /show' do
    let(:drone) { FactoryBot.create(:drone) }

    it 'returns a drone' do
      get "/drones/#{drone.id}"

      response_json = JSON.parse(response.body)
      %w[name faa_registration_number drone_type_id].each do |attribute|
        expect(response_json[attribute]).to eq(drone.send(attribute))
      end
    end
  end

  describe 'POST /create' do
    let(:drone_type) { FactoryBot.create(:drone_type) }
    let(:response_json) { JSON.parse(response.body) }
    let(:request) { post '/drones', params: { drone: params } }

    context 'with valid params' do
      let(:params) { FactoryBot.attributes_for(:drone, drone_type_id: drone_type.id) }

      it 'responds with http status created' do
        request
        expect(response).to have_http_status(:created)
      end

      it 'responds with the created drone' do
        request
        %w[name faa_registration_number drone_type_id].each do |attribute|
          expect(response_json[attribute].to_s).to eq(params[attribute.to_sym].to_s)
        end
      end

      it 'creates a drone in the database' do
        expect { request }.to change(Drone, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:params) { { name: 'Drone Name', faa_registration_number: nil, drone_type_id: drone_type.id } }

      it 'responds with http status bad request' do
        request
        expect(response).to have_http_status(:bad_request)
      end

      it 'responds with the errors' do
        request
        error_response = response_json.find { |field| field['attribute'] = 'faa_registration_number' }
        expect(error_response['type']).to eq('blank')
      end

      it 'does not create a drone in the database' do
        expect { request }.not_to change(Drone, :count)
      end
    end
  end
end
