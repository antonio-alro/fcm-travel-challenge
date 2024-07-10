class SegmentSerializer < BaseSerializer
  attr_reader :accomodation_kinds

  def initialize(object, accomodation_kinds: SegmentEntity::ACCOMMODATION_KINDS.keys)
    @accomodation_kinds = accomodation_kinds
    super(object)
  end

  def serializable_message
    return accomodation_message if accomodation_kinds.include?(object.kind)

    transport_message
  end

  private

  def accomodation_message
    I18n.t(
      "segments.labels.accommodation",
      kind: object.kind.capitalize,
      destination: object.destination_city,
      beginning_date: I18n.l(object.starts_at, format: :date),
      end_date: I18n.l(object.ends_at, format: :date)
    )
  end

  def transport_message
    I18n.t(
      "segments.labels.transport",
      kind: object.kind.capitalize,
      origin: object.origin_city,
      destination: object.destination_city,
      beginning_date: I18n.l(object.starts_at),
      end_date: I18n.l(object.ends_at, format: :hour)
    )
  end
end
