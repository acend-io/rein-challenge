# frozen_string_literal: true

class DronesController < ApplicationController
  def index
    drones = Drone.all
    render json: DroneBlueprint.render(drones)
  end

  def show
    drone = Drone.find(params[:id])
    render json: DroneBlueprint.render(drone)
  end

  def create
    drone = Drone.new(drone_params)
    if drone.save
      render json: DroneBlueprint.render(drone), status: :created
    else
      render json: ErrorBlueprint.render(drone.errors.errors), status: :bad_request
    end
  end

  private

  def drone_params
    params.require(:drone).permit(:name, :faa_registration_number, :drone_type_id)
  end
end
