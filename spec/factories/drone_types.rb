# frozen_string_literal: true

FactoryBot.define do
  factory :drone_type do
    manufacturer { 'DJI' }
    model { 'Phantom 3' }
    wing_type { :rotor }
  end

  factory :fixed, class: 'DroneType' do
    manufacturer { 'Parrot' }
    model { 'Swing' }
    wing_type { :fixed }
  end
end
