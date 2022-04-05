# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def handle_not_found
    render nothing: true, status: :not_found
  end
end
