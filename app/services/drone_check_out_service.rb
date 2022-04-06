# frozen_string_literal: true

class DroneCheckOutService
  class Error < StandardError
    attr_accessor :errors

    def initialize(message:, errors:)
      super(message)
      self.errors = errors
    end
  end

  attr_accessor :pilot_id, :drone_id, :date, :errors, :pilot, :drone
  attr_reader :checkout

  def initialize(drone_id:, pilot_id:, date:)
    self.drone_id = drone_id
    self.pilot_id = pilot_id
    self.date = date
  end

  def valid?
    self.errors = []
    validate_passed_parameters
    return false unless errors.empty?

    check_it_out
    validate_checkout
    return false unless errors.empty?

    true
  end

  def validate!
    return if valid?

    error = Error.new(message: 'Invalid Contract!', errors: errors)
    raise error
  end

  def call!
    validate!
    checkout.save!
    checkout
  end

  private

  def validate_passed_parameters
    errors << { attribute: :pilot_id, full_message: 'Invalid pilot_id passed!' } unless pilot?
    errors << { attribute: :drone_id, full_message: 'Invalid drone_id passed!' } unless drone?
    errors << { attribute: :date, full_message: 'Invalid date passed!' } unless date?
  end

  def validate_checkout
    self.errors += checkout.errors.errors unless checkout.valid?
  end

  def pilot?
    self.pilot_id = string_to_an_integer(pilot_id) if pilot_id.is_a?(String)
    return false unless pilot_id.is_a?(Integer)

    self.pilot = Pilot.find(pilot_id)
    true
  end

  def drone?
    self.drone_id = string_to_an_integer(drone_id) if drone_id.is_a?(String)
    return false unless drone_id.is_a?(Integer)

    self.drone = Drone.find(drone_id)
    true
  end

  def date?
    return false unless date
    return true if date.is_a?(Date)

    self.date = Date.parse(date)
    true
  rescue Date::Error
    false
  end

  def check_it_out
    @checkout ||= PilotDroneCheckout.new(pilot: pilot, drone: drone, date: date)
    nil
  end

  def string_to_an_integer(value)
    return nil unless value.is_a?(String)

    result = value.to_i
    result if result.to_s == value
  end
end
