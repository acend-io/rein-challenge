# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pilots', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create(:pilot)
    end

    it 'returns an array of pilots' do
      get '/pilots'

      response_json = JSON.parse(response.body)
      expect(response_json.length).to eq 1
    end
  end

  describe 'GET /show' do
    let(:pilot) { FactoryBot.create(:pilot) }

    it 'returns a pilot' do
      get "/pilots/#{pilot.id}"

      response_json = JSON.parse(response.body)
      %w[name license_type].each do |attribute|
        expect(response_json[attribute]).to eq(pilot.send(attribute))
      end
    end
  end

  describe 'POST /create' do
    let(:response_json) { JSON.parse(response.body) }
    let(:request) { post '/pilots', params: { pilot: params } }

    context 'with valid params' do
      let(:params) { FactoryBot.attributes_for(:pilot) }

      it 'responds with http status created' do
        request
        expect(response).to have_http_status(:created)
      end

      it 'responds with the created pilot' do
        request
        %w[name license_type].each do |attribute|
          expect(response_json[attribute]).to eq(params[attribute.to_sym].to_s)
        end
      end

      it 'creates a pilot in the database' do
        expect { request }.to change(Pilot, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:params) { { name: nil, license_type: :type107 } }

      it 'responds with http status bad request' do
        request
        expect(response).to have_http_status(:bad_request)
      end

      it 'responds with the errors' do
        request
        error_response = response_json.find { |field| field['attribute'] = 'name' }
        expect(error_response['type']).to eq('blank')
      end

      it 'does not create a pilot in the database' do
        expect { request }.not_to change(Pilot, :count)
      end
    end
  end

  describe 'POST /checkout' do
    let(:pilot) { FactoryBot.create(:pilot) }
    let(:drone) { FactoryBot.create(:drone) }
    let(:date) { (DateTime.now - 1.day).to_date }
    let(:request) { post "/pilots/#{pilot.id}/checkout", params: { date: date, drone_id: drone.id } }
    let(:response_json) { JSON.parse(response.body) }

    context 'with valid params' do
      it 'creates checkout' do
        expect { request }.to change(PilotDroneCheckout, :count).by(1)
      end

      it 'responds with a created checkout' do
        request
        expect(response_json).to include('date' => date.to_s, 'pilot_id' => pilot.id, 'drone_id' => drone.id)
      end
    end

    context 'with validation errors' do
      # rubocop:disable RSpec/AnyInstance
      it 'returns 400 on validation errors' do
        allow_any_instance_of(DroneCheckOutService).to receive(:pilot?).and_return false
        request
        expect(response.status).to eq 400
      end
      # rubocop:enable RSpec/AnyInstance
    end
  end
end
