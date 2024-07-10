require 'rails_helper'

RSpec.describe Segments::GroupSegmentsPerTripService, type: :service do
  let(:base_city) { 'SVQ' }

  describe '#call' do
    it 'returns the segments grouped per trip' do
      segment_1 = SegmentEntity.new(kind: 'flight', origin_city: 'SVQ', destination_city: 'BCN', starts_at: DateTime.parse('2023-01-05 20:40'), ends_at: DateTime.parse('2023-01-05 22:10'))
      segment_2 = SegmentEntity.new(kind: 'hotel', origin_city: 'BCN', destination_city: 'BCN', starts_at: Date.parse('2023-01-05').end_of_day, ends_at: Date.parse('2023-01-10').beginning_of_day)
      segment_3 = SegmentEntity.new(kind: 'flight', origin_city: 'BCN', destination_city: 'SVQ', starts_at: DateTime.parse('2023-01-10 10:30'), ends_at: DateTime.parse('2023-01-10 11:50'))
      segment_4 = SegmentEntity.new(kind: 'train', origin_city: 'SVQ', destination_city: 'MAD', starts_at: DateTime.parse('2023-02-15 09:30'), ends_at: DateTime.parse('2023-02-15 11:00'))
      segment_5 = SegmentEntity.new(kind: 'hotel', origin_city: 'MAD', destination_city: 'MAD', starts_at: Date.parse('2023-02-15').end_of_day, ends_at: Date.parse('2023-02-17').beginning_of_day)
      segment_6 = SegmentEntity.new(kind: 'train', origin_city: 'MAD', destination_city: 'SVQ', starts_at: DateTime.parse('2023-02-17 17:00'), ends_at: DateTime.parse('2023-02-17 19:30'))
      segment_7 = SegmentEntity.new(kind: 'flight', origin_city: 'SVQ', destination_city: 'BCN', starts_at: DateTime.parse('2023-03-02 06:40'), ends_at: DateTime.parse('2023-03-02 09:10'))
      segment_8 = SegmentEntity.new(kind: 'flight', origin_city: 'BCN', destination_city: 'NYC', starts_at: DateTime.parse('2023-03-02 15:00'), ends_at: DateTime.parse('2023-03-02 22:45'))

      service = described_class.new(
        base_city: base_city,
        ordered_segments: [segment_1, segment_2, segment_3, segment_4, segment_5, segment_6, segment_7, segment_8]
      )

      expect(service.calculate_destination_city_service).to receive(:call)
        .with(base_city: 'SVQ', segments: [segment_1, segment_2, segment_3])
        .and_call_original

      expect(service.calculate_start_date_service).to receive(:call)
        .with(segments: [segment_1, segment_2, segment_3])
        .and_call_original

      expect(service.trip_entity).to receive(:new)
        .with(destination_city: 'BCN', start_date: Date.parse('2023-01-05'), segments: [segment_1, segment_2, segment_3])
        .and_call_original

      expect(service.calculate_destination_city_service).to receive(:call)
        .with(base_city: 'SVQ', segments: [segment_4, segment_5, segment_6])
        .and_call_original

      expect(service.calculate_start_date_service).to receive(:call)
        .with(segments: [segment_4, segment_5, segment_6])
        .and_call_original

      expect(service.trip_entity).to receive(:new)
        .with(destination_city: 'MAD', start_date: Date.parse('2023-02-15'), segments: [segment_4, segment_5, segment_6])
        .and_call_original

      expect(service.calculate_destination_city_service).to receive(:call)
        .with(base_city: 'SVQ', segments: [segment_7, segment_8])
        .and_call_original

      expect(service.calculate_start_date_service).to receive(:call)
        .with(segments: [segment_7, segment_8])
        .and_call_original

      expect(service.trip_entity).to receive(:new)
        .with(destination_city: 'NYC', start_date: Date.parse('2023-03-02'), segments: [segment_7, segment_8])
        .and_call_original

      trips = service.call

      expect(trips.count).to eq(3)
    end
  end
end
