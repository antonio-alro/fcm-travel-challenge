require 'rails_helper'

RSpec.describe GetItineraryUseCase, type: :use_case do
  subject(:use_case_klass) { described_class }

  describe '#perform' do
    it 'calls the expected services and return the list of trips' do
      fake_input = OpenStruct.new(base_city: 'SVQ', filename: 'fake_input.txt')
      segment_1 = SegmentEntity.new(kind: 'flight', origin_city: 'SVQ', destination_city: 'BCN', starts_at: DateTime.parse('2023-01-05 20:40'), ends_at: DateTime.parse('2023-01-05 22:10'))
      segment_2 = SegmentEntity.new(kind: 'hotel', origin_city: 'BCN', destination_city: 'BCN', starts_at: Date.parse('2023-01-05').end_of_day, ends_at: Date.parse('2023-01-10').beginning_of_day)
      segment_3 = SegmentEntity.new(kind: 'flight', origin_city: 'BCN', destination_city: 'SVQ', starts_at: DateTime.parse('2023-01-10 10:30'), ends_at: DateTime.parse('2023-01-10 11:50'))
      trip = TripEntity.new(destination_city: 'BCN', start_date: Date.parse('2023-01-05'), segments: [segment_1, segment_2, segment_3])

      use_case = use_case_klass.new(
        get_segments_from_input_service: self.class::FakeGetSegmentsFromInputService.with_segments([segment_2, segment_3, segment_1]),
        order_segments_service: self.class::FakeOrderSegmentsService.with_segments([segment_1, segment_2, segment_3]),
        group_segments_per_trip_service: self.class::FakeGroupSegmentsPerTripService.with_trips([trip])
      )

      expect(use_case.get_segments_from_input_service).to receive(:new)
        .with(filename: 'fake_input.txt')
        .and_call_original

      expect(use_case.order_segments_service).to receive(:call)
        .with(segments: [segment_2, segment_3, segment_1])
        .and_call_original

      expect(use_case.group_segments_per_trip_service).to receive(:new)
        .with(base_city: 'SVQ', ordered_segments: [segment_1, segment_2, segment_3])
        .and_call_original

      result = use_case.perform(input: fake_input)

      expect(result).to eq([trip])
    end
  end

  class self::FakeGetSegmentsFromInputService
    attr_reader :segments

    def self.with_segments(segments)
      @@segments = segments
      self
    end

    def initialize(*); end

    def call
      @@segments
    end
  end

  class self::FakeOrderSegmentsService
    attr_reader :segments

    def self.with_segments(segments)
      @@segments = segments
      self
    end

    def self.call(*)
      @@segments
    end
  end

  class self::FakeGroupSegmentsPerTripService
    attr_reader :trips

    def self.with_trips(trips)
      @@trips = trips
      self
    end

    def initialize(*); end

    def call
      @@trips
    end
  end
end
