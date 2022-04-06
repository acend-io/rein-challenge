# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PilotDroneCheckouts', type: :request do
  let(:pilot) { FactoryBot.create(:pilot) }
  let(:drone) { FactoryBot.create(:drone) }
  let(:response_json) { JSON.parse(response.body) }

  describe 'GET /checkouts' do
    let(:request) { get '/checkouts' }

    before do
      FactoryBot.create_list(:pilot_drone_checkout, 3, pilot: pilot, drone: drone)
    end

    it 'returns all checkouts' do
      request
      expect(response_json.count).to eq 3
    end

    it 'contains pilot data' do
      request
      expect(response_json.map do |el|
               el['pilot']
             end.first).to eq(pilot.attributes.except('created_at', 'updated_at'))
    end

    it 'contains drone data' do
      request
      expect(response_json.map do |el|
               el['drone']
             end.first).to eq(drone.attributes.except('created_at', 'updated_at'))
    end

    it 'contains dates' do
      request
      expect(response_json.map do |el|
               Date.parse(el['date'])
             end.flatten).to contain_exactly(*PilotDroneCheckout.pluck(:date))
    end
  end

  describe 'POST /checkouts' do
    let(:date) { (DateTime.now - 1.day).to_date }
    let(:request) { post '/checkouts', params: { date: date, drone_id: drone.id, pilot_id: pilot.id } }
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
      it 'returns 400 on validation errors' do
        # rubocop:disable RSpec/AnyInstance
        allow_any_instance_of(DroneCheckOutService).to receive(:pilot?).and_return false
        request
        expect(response.status).to eq 400
        # rubocop:enable RSpec/AnyInstance
      end
    end
  end
end
