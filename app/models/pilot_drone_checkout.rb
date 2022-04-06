# frozen_string_literal: true

class PilotDroneCheckout < ApplicationRecord
  belongs_to :pilot
  belongs_to :drone

  # In the scope of our task we don't need to check the uniqueness of :date in the scope of :pilot_id,
  # but it seems to be logical to make that check
  validates :date, presence: true, uniqueness: { scope: %i[pilot_id drone_id] }
end
