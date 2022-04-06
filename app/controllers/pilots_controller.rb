# frozen_string_literal: true

class PilotsController < ApplicationController
  include Checkoutable
  before_action :set_pilot, only: %i[show checkout]

  def index
    pilots = Pilot.all
    render json: PilotBlueprint.render(pilots)
  end

  def show
    render json: PilotBlueprint.render(@pilot)
  end

  def create
    pilot = Pilot.new(pilot_params)
    if pilot.save
      render json: PilotBlueprint.render(pilot), status: :created
    else
      render json: ErrorBlueprint.render(pilot.errors.errors), status: :bad_request
    end
  end

  def checkout
    service = DroneCheckOutService.new(pilot_id: @pilot.id, drone_id: params[:drone_id], date: params[:date])
    render json: PilotDroneCheckoutBlueprint.render(service.call!)
  end

  private

  def pilot_params
    params.require(:pilot).permit(:name, :license_type)
  end

  def set_pilot
    @pilot = Pilot.find(params[:id])
  end
end
