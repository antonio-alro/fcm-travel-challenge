require 'rails_helper'

RSpec.describe TripEntity, type: :entity do
  subject(:domain_entity) do
    described_class.new(
      destination_city: destination_city,
      start_date: start_date,
      segments: [fake_segment]
    )
  end

  let(:destination_city) { 'MAD' }
  let(:start_date) { 2.days.ago.to_date }
  let(:fake_segment) { OpenStruct.new }

  specify { expect(domain_entity.destination_city).to eq('MAD') }
  specify { expect(domain_entity.start_date).to eq(start_date) }
  specify { expect(domain_entity.segments).to eq([fake_segment]) }
end
