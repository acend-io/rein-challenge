# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PilotDroneCheckout, type: :model do
  subject { FactoryBot.create(:pilot_drone_checkout) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_uniqueness_of(:date).scoped_to(:pilot_id, :drone_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to :pilot }
    it { is_expected.to belong_to :drone }
  end
end
