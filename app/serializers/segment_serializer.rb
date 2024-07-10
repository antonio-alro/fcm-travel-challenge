class SegmentSerializer < BaseSerializer
  def serializable_message
    return accommodation_message if object.is_accommodation?

    transport_message
  end

  private

  def accommodation_message
    I18n.t(
      "segments.labels.accommodation",
      kind: object.kind_text,
      destination: object.destination_city,
      beginning_date: I18n.l(object.starts_at, format: :date),
      end_date: I18n.l(object.ends_at, format: :date)
    )
  end

  def transport_message
    I18n.t(
      "segments.labels.transport",
      kind: object.kind_text,
      origin: object.origin_city,
      destination: object.destination_city,
      beginning_date: I18n.l(object.starts_at),
      end_date: I18n.l(object.ends_at, format: :hour)
    )
  end
end
