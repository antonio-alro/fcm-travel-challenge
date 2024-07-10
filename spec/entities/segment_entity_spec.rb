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
end
