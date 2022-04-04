# frozen_string_literal: true

class DroneTypesController < ApplicationController
  def index
    drone_types = DroneType.all
    render json: DroneTypeBlueprint.render(drone_types)
  end

  def create
    drone_type = DroneType.new(drone_type_params)
    if drone_type.save
      render json: DroneTypeBlueprint.render(drone_type), status: :created
    else
      render json: ErrorBlueprint.render(drone_type.errors.errors), status: :bad_request
    end
  end

  def show
    drone_type = DroneType.find(params[:id])
    render json: DroneTypeBlueprint.render(drone_type)
  end

  private

  def drone_type_params
    params.require(:drone_type).permit(:manufacturer, :model, :wing_type)
  end
end
