# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pilot, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:pilot_drone_checkouts) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:license_type) }
    it { is_expected.to define_enum_for(:license_type) }
  end
end
