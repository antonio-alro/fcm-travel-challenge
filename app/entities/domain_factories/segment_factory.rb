module DomainFactories
  class SegmentFactory
    def self.initialize_segment_for_accommodation(accommodation_captures, domain_entity_klass: SegmentEntity)
      domain_entity_klass.new(
        kind: domain_entity_klass::ACCOMMODATION_KINDS.invert[accommodation_captures[0]],
        origin_city: accommodation_captures[1],
        destination_city: accommodation_captures[1],
        starts_at: Date.parse(accommodation_captures[2]).end_of_day,
        ends_at: Date.parse(accommodation_captures[3]).beginning_of_day
      )
    end

    def self.initialize_segment_for_transport(transport_captures, domain_entity_klass: SegmentEntity)
      domain_entity_klass.new(
        kind: domain_entity_klass::TRANSPORT_KINDS.invert[transport_captures[0]],
        origin_city: transport_captures[1],
        destination_city: transport_captures[4],
        starts_at: DateTime.parse(transport_captures[2]),
        ends_at: DateTime.parse("#{transport_captures[3]} #{transport_captures[5]}")
      )
    end
  end
end
