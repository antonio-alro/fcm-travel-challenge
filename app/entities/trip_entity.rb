class TripEntity
  attr_reader :destination_city, :start_date, :segments

  def initialize(destination_city:, start_date:, segments:)
    @destination_city = destination_city
    @start_date = start_date
    @segments = segments
  end
end
