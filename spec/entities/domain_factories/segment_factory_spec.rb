require 'rails_helper'

RSpec.describe DomainFactories::SegmentFactory, type: :entity do
  subject(:domain_factory) { described_class }

  describe '#initialize_segment_for_accommodation' do
    let(:accommodation_captures) { ['Hotel', 'BCN', '2023-01-05', '2023-01-10'] }

    it 'returns a segment domain entity' do
      expect(domain_factory.initialize_segment_for_accommodation(accommodation_captures)).to be_a(SegmentEntity)
    end

    it 'initializes the entity with the expected data' do
      expect(SegmentEntity).to receive(:new)
        .with(
          kind: 'hotel',
          origin_city: 'BCN',
          destination_city: 'BCN',
          starts_at: Date.parse('2023-01-05').end_of_day,
          ends_at: Date.parse('2023-01-10').beginning_of_day
        )
        .and_call_original

      domain_factory.initialize_segment_for_accommodation(accommodation_captures)
    end
  end

  describe '#initialize_segment_for_transport' do
    let(:transport_captures) { ['Flight', 'SVQ', '2023-03-02 06:40', '2023-03-02', 'BCN', '09:10'] }

    it 'returns a segment domain entity' do
      expect(domain_factory.initialize_segment_for_transport(transport_captures)).to be_a(SegmentEntity)
    end

    it 'initializes the entity with the expected data' do
      expect(SegmentEntity).to receive(:new)
        .with(
          kind: 'flight',
          origin_city: 'SVQ',
          destination_city: 'BCN',
          starts_at: DateTime.parse('2023-03-02 06:40'),
          ends_at: DateTime.parse('2023-03-02 09:10')
        )
        .and_call_original

      domain_factory.initialize_segment_for_transport(transport_captures)
    end
  end
end
