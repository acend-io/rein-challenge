# frozen_string_literal: true

FactoryBot.define do
  factory :drone do
    association :drone_type
    name { 'Drone 1' }
    faa_registration_number { 'FA2342342' }
  end
end
