# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DroneCheckOutService' do
  # rubocop:disable RSpec/MultipleExpectations
  let(:pilot) { FactoryBot.create(:pilot) }
  let(:drone) { FactoryBot.create(:drone) }
  let(:date) { (DateTime.now - 1.day).to_date }

  describe 'validations' do
    it 'pass' do
      expect { DroneCheckOutService.new(pilot_id: pilot.id, drone_id: drone.id, date: date).call! }.not_to raise_error
    end

    describe 'Pilot' do
      it 'not found' do
        service = DroneCheckOutService.new(pilot_id: 9999, drone_id: drone.id, date: date)
        expect { service.call! }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'blank' do
        service = DroneCheckOutService.new(pilot_id: nil, drone_id: drone.id, date: date)
        expect { service.call! }.to raise_error(DroneCheckOutService::Error, 'Invalid Contract!')
        expect(service.errors).to include(attribute: :pilot_id, full_message: 'Invalid pilot_id passed!')
      end

      it 'invalid' do
        service = DroneCheckOutService.new(pilot_id: 'string', drone_id: drone.id, date: date)
        expect { service.call! }.to raise_error(DroneCheckOutService::Error, 'Invalid Contract!')
        expect(service.errors).to include(attribute: :pilot_id, full_message: 'Invalid pilot_id passed!')
      end

      it 'text as a string' do
        service = DroneCheckOutService.new(pilot_id: pilot.id.to_s, drone_id: drone.id, date: date)
        expect { service.call! }.not_to raise_error
      end
    end

    describe 'Drone' do
      it 'not found' do
        service = DroneCheckOutService.new(pilot_id: pilot.id, drone_id: 99_999, date: date)
        expect { service.call! }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'blank' do
        service = DroneCheckOutService.new(pilot_id: pilot.id, drone_id: nil, date: date)
        expect { service.call! }.to raise_error(DroneCheckOutService::Error, 'Invalid Contract!')
        expect(service.errors).to include(attribute: :drone_id, full_message: 'Invalid drone_id passed!')
      end

      it 'invalid' do
        service = DroneCheckOutService.new(pilot_id: pilot.id, drone_id: 'string', date: date)
        expect { service.call! }.to raise_error(DroneCheckOutService::Error, 'Invalid Contract!')
        expect(service.errors).to include(attribute: :drone_id, full_message: 'Invalid drone_id passed!')
      end

      it 'text as a string' do
        service = DroneCheckOutService.new(pilot_id: pilot.id, drone_id: drone.id.to_s, date: date)
        expect { service.call! }.not_to raise_error
      end
    end

    describe 'date' do
      it 'blank' do
        service = DroneCheckOutService.new(pilot_id: pilot.id, drone_id: drone.id, date: nil)
        expect { service.call! }.to raise_error(DroneCheckOutService::Error, 'Invalid Contract!')
        expect(service.errors).to include(attribute: :date, full_message: 'Invalid date passed!')
      end

      it 'invalid' do
        service = DroneCheckOutService.new(pilot_id: pilot.id, drone_id: drone.id, date: 'not_a_date')
        expect { service.call! }.to raise_error(DroneCheckOutService::Error, 'Invalid Contract!')
        expect(service.errors).to include(attribute: :date, full_message: 'Invalid date passed!')
      end

      it 'String' do
        service = DroneCheckOutService.new(pilot_id: pilot.id, drone_id: drone.id, date: date.to_s)
        expect { service.call! }.not_to raise_error
      end
    end
  end

  describe 'execution' do
    # rubocop:disable RSpec/ExampleLength
    it 'creates checkout' do
      DroneCheckOutService.new(pilot_id: pilot.id, drone_id: drone.id, date: date).call!
      result = PilotDroneCheckout.first
      expect(result).to be_present
      expect(result.pilot).to eq(pilot)
      expect(result.drone).to eq(drone)
      expect(result.date).to eq(date)
    end
    # rubocop:enable RSpec/ExampleLength

    it 'doesn\'t create checkout if validation failed' do
      service = DroneCheckOutService.new(pilot_id: pilot.id, drone_id: drone.id, date: date)
      allow(service).to receive(:valid?).and_return false
      expect { service.call! }.to raise_error(StandardError)
      result = PilotDroneCheckout.first
      expect(result).not_to be_present
    end
  end
  # rubocop:enable RSpec/MultipleExpectations
end
