# frozen_string_literal: true

class Drone < ApplicationRecord
  validates :name, presence: true
  validates :faa_registration_number, presence: true, uniqueness: true

  belongs_to :drone_type
end
