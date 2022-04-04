# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Drone, type: :model do
  describe 'validations' do
    subject { FactoryBot.create(:drone) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:faa_registration_number) }
    it { is_expected.to validate_uniqueness_of(:faa_registration_number) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:drone_type) }
  end
end
