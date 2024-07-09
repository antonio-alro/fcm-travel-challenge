# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trips::CalculateDestinationCityService, type: :service do
  subject(:service) { described_class }

  describe '#call' do
    it 'returns the expected destination_city' do
      segment_1 = { kind: 'flight', origin_city: 'SVQ', destination_city: 'BCN', starts_at: DateTime.parse('2023-01-05 20:40') }
      segment_2 = { kind: 'hotel', origin_city: 'BCN', destination_city: 'BCN', starts_at: DateTime.parse('2023-01-05 23:59') }
      segment_3 = { kind: 'flight', origin_city: 'BCN', destination_city: 'SVQ', starts_at: DateTime.parse('2023-01-10 10:30') }

      result = service.call(base_city: 'SVQ', segments: [segment_1, segment_2, segment_3])

      expect(result).to eq('BCN')
    end
  end
end
