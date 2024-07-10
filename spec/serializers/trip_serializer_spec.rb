require 'rails_helper'

RSpec.describe TripSerializer, type: :serializer do
  subject(:serializer) { described_class.new(segment, accomodation_kinds: ['hotel']) }

  describe '#serializable_message' do
    it 'returns the expected text' do
      segment = SegmentEntity.new(
        kind: 'flight',
        origin_city: 'SVQ',
        destination_city: 'BCN',
        starts_at: DateTime.parse('2023-03-02 06:40'),
        ends_at: DateTime.parse('2023-03-02 09:10')
      )
      trip = TripEntity.new(
        destination_city: 'MAD',
        start_date: 2.days.ago,
        segments: [segment]
      )
      serializer = described_class.new(
        trip,
        segment_serializer: self.class::FakeSegmentSerializer
      )

      expect(serializer.serializable_message).to eq("TRIP to MAD\nFlight to anywhere")
    end
  end

  class self::FakeSegmentSerializer
    def initialize(*); end

    def serializable_message
      'Flight to anywhere'
    end
  end
end
