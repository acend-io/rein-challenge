# frozen_string_literal: true

class PilotDroneCheckoutsController < ApplicationController
  include Checkoutable

  def index
    checkouts = PilotDroneCheckout.all
    render json: PilotDroneCheckoutBlueprint.render(checkouts)
  end

  def create
    service = DroneCheckOutService.new(pilot_id: params[:pilot_id], drone_id: params[:drone_id],
                                       date: params[:date])
    render json: PilotDroneCheckoutBlueprint.render(service.call!)
  end
end
