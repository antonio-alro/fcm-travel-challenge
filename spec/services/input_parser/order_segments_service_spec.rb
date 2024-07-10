# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InputParser::OrderSegmentsService, type: :service do
  subject(:service) { described_class }

  describe '#call' do
    it 'returns the segments ordered by start date' do
      segment_1 = SegmentEntity.new(
        kind: 'flight',
        origin_city: 'SVQ',
        destination_city: 'BCN',
        starts_at: DateTime.parse('2023-03-02 06:40'),
        ends_at: DateTime.parse('2023-03-02 09:10')
      )
      segment_2 = SegmentEntity.new(
        kind: 'flight',
        origin_city: 'SVQ',
        destination_city: 'BCN',
        starts_at: DateTime.parse('2023-03-02 12:30'),
        ends_at: DateTime.parse('2023-03-02 15:00')
      )

      result = service.call(segments: [segment_2, segment_1])

      expect(result).to eq([segment_1, segment_2])
    end
  end
end
