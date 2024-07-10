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
end
