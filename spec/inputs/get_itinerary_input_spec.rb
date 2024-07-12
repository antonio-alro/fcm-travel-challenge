require 'rails_helper'

RSpec.describe GetItineraryInput, type: :input do
  subject(:input) { described_class.new(base_city: base_city, filename: filename) }

  let(:base_city) { 'SVQ' }
  let(:filename) { 'input.txt' }

  describe '#invalid?' do
    context 'when the base_city is not present' do
      let(:base_city) { nil }

      it 'returns true' do
        expect(input.invalid?).to eq(true)
      end
    end

    context 'when the filename is not present' do
      let(:filename) { nil }

      it 'returns true' do
        expect(input.invalid?).to eq(true)
      end
    end

    context 'when the base_city and the filename are present' do
      it 'returns false' do
        expect(input.invalid?).to eq(false)
      end
    end
  end
end
