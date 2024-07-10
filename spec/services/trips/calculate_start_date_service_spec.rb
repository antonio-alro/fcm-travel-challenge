# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trips::CalculateStartDateService, type: :service do
  subject(:service) { described_class }

  describe '#call' do
    it 'returns the expected start date' do
      segment_1 = OpenStruct.new(kind: 'flight', starts_at: DateTime.parse('2023-03-02 06:40'))
      segment_2 = OpenStruct.new(kind: 'flight', starts_at: DateTime.parse('2023-03-03 12:30'))

      result = service.call(segments: [segment_1, segment_2])

      expect(result).to eq(Date.parse('2023-03-02'))
    end
  end
end
