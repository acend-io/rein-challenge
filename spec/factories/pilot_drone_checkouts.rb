# frozen_string_literal: true

FactoryBot.define do
  factory :pilot_drone_checkout do
    association :pilot
    association :drone

    date
  end

  sequence :date do |n|
    DateTime.now.to_date + n.days
  end
end
