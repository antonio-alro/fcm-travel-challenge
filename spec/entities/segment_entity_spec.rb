require 'rails_helper'

RSpec.describe SegmentEntity, type: :entity do
  subject(:domain_entity) do
    described_class.new(
      kind: kind,
      origin_city: origin_city,
      destination_city: destination_city,
      starts_at: starts_at,
      ends_at: ends_at
    )
  end

  let(:kind) { 'flight' }
  let(:origin_city) { 'SVQ' }
  let(:destination_city) { 'MAD' }
  let(:starts_at) { 2.days.ago }
  let(:ends_at) { starts_at + 3.hours }

  specify { expect(domain_entity.kind).to eq('flight') }
  specify { expect(domain_entity.origin_city).to eq('SVQ') }
  specify { expect(domain_entity.destination_city).to eq('MAD') }
  specify { expect(domain_entity.starts_at).to eq(starts_at) }
  specify { expect(domain_entity.ends_at).to eq(ends_at) }

  describe '.ACCOMMODATION_KINDS' do
    specify { expect(described_class::ACCOMMODATION_KINDS).to eq({ 'hotel' => 'Hotel' }) }
  end

  describe '.TRANSPORT_KINDS' do
    specify { expect(described_class::TRANSPORT_KINDS).to eq({ 'flight' => 'Flight', 'train' => 'Train' }) }
  end

  describe '#is_accommodation?' do
    context 'when the segment is a hotel' do
      let(:kind) { 'hotel' }

      specify { expect(domain_entity.is_accommodation?).to eq(true) }
    end

    context 'when the segment is a flight' do
      let(:kind) { 'flight' }

      specify { expect(domain_entity.is_accommodation?).to eq(false) }
    end

    context 'when the segment is a train' do
      let(:kind) { 'train' }

      specify { expect(domain_entity.is_accommodation?).to eq(false) }
    end
  end

  describe '#kind_text' do
    context 'when the segment is a hotel' do
      let(:kind) { 'hotel' }

      specify { expect(domain_entity.kind_text).to eq('Hotel') }
    end

    context 'when the segment is a flight' do
      let(:kind) { 'flight' }

      specify { expect(domain_entity.kind_text).to eq('Flight') }
    end

    context 'when the segment is a train' do
      let(:kind) { 'train' }

      specify { expect(domain_entity.kind_text).to eq('Train') }
    end
  end
end
