# frozen_string_literal: true

class Pilot < ApplicationRecord
  validates :name, presence: true
  validates :license_type, presence: true

  enum license_type: {
    type107: 0,
    type333: 1,
    government_exemption: 2
  }, _prefix: true
end
