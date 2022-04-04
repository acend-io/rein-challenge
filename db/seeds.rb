# frozen_string_literal: true

drone_types = []
[
  { manufacturer: 'DJI', model: 'Phantom 3', wing_type: :rotor },
  { manufacturer: 'Parrot', model: 'Swing', wing_type: :fixed }
].each do |drone_type|
  drone_types << DroneType.create!(drone_type)
end

30.times do |i|
  drone_types.sample.drones.create!(name: "Drone #{i}", faa_registration_number: "FA#{i}")
end

30.times do |i|
  license_type = %i[type107 type333 government_exemption].sample
  Pilot.create!(name: "Pilot #{i}", license_type: license_type)
end
