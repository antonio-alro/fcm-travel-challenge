require 'rails_helper'

RSpec.describe Trips::CalculateDestinationCityService, type: :service do
  subject(:service) { described_class }

  describe '#call' do
    it 'returns the expected destination_city' do
      segment_1 = OpenStruct.new(origin_city: 'SVQ', destination_city: 'BCN')
      segment_2 = OpenStruct.new(origin_city: 'BCN', destination_city: 'BCN')
      segment_3 = OpenStruct.new(origin_city: 'BCN', destination_city: 'SVQ')

      result = service.call(base_city: 'SVQ', segments: [segment_1, segment_2, segment_3])

      expect(result).to eq('BCN')
    end
  end
end
