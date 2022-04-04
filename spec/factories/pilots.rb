# frozen_string_literal: true

FactoryBot.define do
  factory :pilot do
    name { 'Mr. Pilot' }
    license_type { :type107 }
  end

  factory :type333, class: 'Pilot', parent: :pilot do
    license_type { :type333 }
  end

  factory :government_exemption, class: 'Pilot', parent: :pilot do
    license_type { :government_exemption }
  end
end
