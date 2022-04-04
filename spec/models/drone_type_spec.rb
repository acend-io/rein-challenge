# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DroneType, type: :model do
  describe 'validations' do
    subject { FactoryBot.create(:drone_type) }

    it { is_expected.to validate_presence_of(:manufacturer) }
    it { is_expected.to validate_presence_of(:model) }
    it { is_expected.to validate_presence_of(:wing_type) }
    it { is_expected.to define_enum_for(:wing_type) }
    it { is_expected.to validate_uniqueness_of(:model).scoped_to(:manufacturer) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:drones) }
  end

  describe '.manufacturers' do
    before do
      2.times do |i|
        FactoryBot.create(:drone_type, manufacturer: 'DJI', model: "Model #{i}")
      end
      FactoryBot.create(:fixed, manufacturer: 'Parrot')
    end

    it 'returns a list of manufacturers' do
      manufacturers = described_class.manufacturers
      expect(manufacturers).to eq(%w[DJI Parrot])
    end

    it 'is a unique list' do
      manufacturers = described_class.manufacturers
      expect(manufacturers.uniq).to eq(manufacturers)
    end
  end
end
