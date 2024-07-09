# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InputParser::ExtractSegmentDataService, type: :service do
  subject(:service) { described_class.new(input_line: input_line) }

  describe '#call' do
    context 'without an input_line' do
      let(:input_line) { nil }

      it 'returns nothing' do
        expect(subject.call).to be_nil
      end
    end

    context 'with an input line that is an accommodation' do
      let(:input_line) { 'SEGMENT: Hotel BCN 2023-01-05 -> 2023-01-10' }

      it 'returns the expected segment data' do
        expected_result = {
          kind: 'hotel',
          origin_city: 'BCN',
          destination_city: 'BCN',
          starts_at: Date.parse('2023-01-05').end_of_day,
          ends_at: Date.parse('2023-01-10').beginning_of_day
        }

        expect(service.call).to eq(expected_result)
      end
    end

    context 'with an input line that is a trip (flight)' do
      let(:input_line) { 'SEGMENT: Flight SVQ 2023-03-02 06:40 -> BCN 09:10' }

      it 'returns the expected segment data' do
        expected_result = {
          kind: 'flight',
          origin_city: 'SVQ',
          destination_city: 'BCN',
          starts_at: DateTime.parse('2023-03-02 06:40'),
          ends_at: DateTime.parse('2023-03-02 09:10')
        }

        expect(service.call).to eq(expected_result)
      end
    end

    context 'with an input line that is a trip (train)' do
      let(:input_line) { 'SEGMENT: Train SVQ 2023-02-15 09:30 -> MAD 11:00' }

      it 'returns the expected segment data' do
        expected_result = {
          kind: 'train',
          origin_city: 'SVQ',
          destination_city: 'MAD',
          starts_at: DateTime.parse('2023-02-15 09:30'),
          ends_at: DateTime.parse('2023-02-15 11:00')
        }

        expect(service.call).to eq(expected_result)
      end
    end

    context 'with another input_line' do
      let(:input_line) { 'SEGMENT: Hotel BARCELONA 2020-01-05 --> 2020-01-10' }

      it 'does not return segment data' do
        expect(subject.call).to eq({})
      end
    end
  end
end
