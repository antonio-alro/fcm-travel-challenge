require 'rails_helper'

RSpec.describe SegmentEntity, type: :entity do
  describe '.ACCOMMODATION_KINDS' do
    specify { expect(described_class::ACCOMMODATION_KINDS).to eq({ 'hotel' => 'Hotel' }) }
  end

  describe '.TRIP_KINDS' do
    specify { expect(described_class::TRIP_KINDS).to eq({ 'flight' => 'Flight', 'train' => 'Train' }) }
  end
end
