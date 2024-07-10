require 'rails_helper'

RSpec.describe SegmentSerializer, type: :serializer do
  subject(:serializer) { described_class.new(segment, accomodation_kinds: ['hotel']) }

  describe '#serializable_message' do
    context 'when the segment is an accommodation' do
      let(:segment) do
        SegmentEntity.new(
          kind: 'hotel',
          origin_city: 'BCN',
          destination_city: 'BCN',
          starts_at: DateTime.parse('2023-01-05 23:59'),
          ends_at: DateTime.parse('2023-01-10 01:00')
        )
      end

      it 'returns the expected text' do
        expect(serializer.serializable_message).to eq('Hotel at BCN on 2023-01-05 to 2023-01-10')
      end
    end

    context 'when the segment is a transport' do
      let(:segment) do
        SegmentEntity.new(
          kind: 'flight',
          origin_city: 'SVQ',
          destination_city: 'BCN',
          starts_at: DateTime.parse('2023-03-02 06:40'),
          ends_at: DateTime.parse('2023-03-02 09:10')
        )
      end

      it 'returns the expected text' do
        expect(serializer.serializable_message).to eq('Flight from SVQ to BCN at 2023-03-02 06:40 to 09:10')
      end
    end
  end
end
