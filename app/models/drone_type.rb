# frozen_string_literal: true

class DroneType < ApplicationRecord
  validates :manufacturer, presence: true
  validates :model, presence: true, uniqueness: { scope: :manufacturer }
  validates :wing_type, presence: true

  has_many :drones, dependent: :destroy

  enum wing_type: {
    fixed: 0,
    rotor: 1
  }

  def self.manufacturers
    group(:manufacturer).pluck(:manufacturer)
  end
end
