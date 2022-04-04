# frozen_string_literal: true

class PilotsController < ApplicationController
  def index
    pilots = Pilot.all
    render json: PilotBlueprint.render(pilots)
  end

  def show
    pilot = Pilot.find(params[:id])
    render json: PilotBlueprint.render(pilot)
  end

  def create
    pilot = Pilot.new(pilot_params)
    if pilot.save
      render json: PilotBlueprint.render(pilot), status: :created
    else
      render json: ErrorBlueprint.render(pilot.errors.errors), status: :bad_request
    end
  end

  private

  def pilot_params
    params.require(:pilot).permit(:name, :license_type)
  end
end
