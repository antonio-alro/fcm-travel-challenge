class SegmentEntity
  ACCOMMODATION_KINDS = { 'hotel' => 'Hotel' }.freeze
  TRANSPORT_KINDS = { 'flight' => 'Flight', 'train' => 'Train' }.freeze

  attr_reader :kind, :origin_city, :destination_city, :starts_at, :ends_at

  def initialize(kind:, origin_city:, destination_city:, starts_at:, ends_at:)
    @kind = kind
    @origin_city = origin_city
    @destination_city = destination_city
    @starts_at = starts_at
    @ends_at = ends_at
  end

  def is_accommodation?
    ACCOMMODATION_KINDS.key?(kind)
  end

  def kind_text
    return ACCOMMODATION_KINDS[kind] if is_accommodation?

    TRANSPORT_KINDS[kind]
  end
end
