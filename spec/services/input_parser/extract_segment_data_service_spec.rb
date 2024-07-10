require 'rails_helper'

RSpec.describe InputParser::ExtractSegmentDataService, type: :service do
  subject(:service) { described_class.new(input_line: input_line) }

  describe '#call' do
    context 'without an input line' do
      let(:input_line) { nil }

      it 'returns nothing' do
        expect(subject.call).to be_nil
      end
    end

    context 'with a not supported input line' do
      let(:input_line) { 'SEGMENT: Hotel BARCELONA 2020-01-05 --> 2020-01-10' }

      it 'returns nothing' do
        expect(subject.call).to be_nil
      end
    end

    context 'with an input line that is an accommodation' do
      let(:input_line) { 'SEGMENT: Hotel BCN 2023-01-05 -> 2023-01-10' }

      it 'returns the expected segment data' do
        fake_segment = SegmentEntity.new(
          kind: 'hotel',
          origin_city: 'BCN',
          destination_city: 'BCN',
          starts_at: Date.parse('2023-01-05').end_of_day,
          ends_at: Date.parse('2023-01-10').beginning_of_day
        )
        service = described_class.new(
          input_line: input_line,
          segment_factory: self.class::FakeSegmentFactory.with_segment(fake_segment)
        )

        expect(service.call).to eq(fake_segment)
      end
    end

    context 'with an input line that is a trip (flight)' do
      let(:input_line) { 'SEGMENT: Flight SVQ 2023-03-02 06:40 -> BCN 09:10' }

      it 'returns the expected segment data' do
        fake_segment = SegmentEntity.new(
          kind: 'flight',
          origin_city: 'SVQ',
          destination_city: 'BCN',
          starts_at: DateTime.parse('2023-03-02 06:40'),
          ends_at: DateTime.parse('2023-03-02 09:10')
        )
        service = described_class.new(
          input_line: input_line,
          segment_factory: self.class::FakeSegmentFactory.with_segment(fake_segment)
        )

        expect(service.call).to eq(fake_segment)
      end
    end

    context 'with an input line that is a trip (train)' do
      let(:input_line) { 'SEGMENT: Train SVQ 2023-02-15 09:30 -> MAD 11:00' }

      it 'returns the expected segment data' do
        fake_segment = SegmentEntity.new(
          kind: 'train',
          origin_city: 'SVQ',
          destination_city: 'MAD',
          starts_at: DateTime.parse('2023-02-15 09:30'),
          ends_at: DateTime.parse('2023-02-15 11:00')
        )
        service = described_class.new(
          input_line: input_line,
          segment_factory: self.class::FakeSegmentFactory.with_segment(fake_segment)
        )

        expect(service.call).to eq(fake_segment)
      end
    end
  end

  class self::FakeSegmentFactory
    attr_reader :segment

    def self.with_segment(segment)
      @@segment = segment
      self
    end

    def self.initialize_segment_for_accommodation(*)
      @@segment
    end

    def self.initialize_segment_for_transport(*)
      @@segment
    end
  end
end
