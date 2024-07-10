require 'rails_helper'

RSpec.describe ItineraryPlainTextTransformer, type: :transformer do
  subject(:transformer) { described_class }

  describe '#call' do
    it 'returns the expected text' do
      trip_1 = OpenStruct.new
      trip_2 = OpenStruct.new

      result = transformer.call(trips: [trip_1, trip_2], trip_serializer: self.class::FakeTripSerializer)

      expect(result).to eq("TRIP to MAD\nFlight to anywhere\n\nTRIP to MAD\nFlight to anywhere")
    end
  end

  class self::FakeTripSerializer
    def initialize(*); end

    def serializable_message
      "TRIP to MAD\nFlight to anywhere"
    end
  end
end
