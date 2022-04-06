# frozen_string_literal: true

module Checkoutable
  extend ActiveSupport::Concern

  included do
    rescue_from DroneCheckOutService::Error, with: :drone_checkout_service_error
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error
  end

  private

  def drone_checkout_service_error(exception)
    render json: ErrorBlueprint.render(exception.errors), status: :bad_request
  end

  def record_not_found_error(exception)
    render json: { message: exception.message }, status: :not_found
  end
end
