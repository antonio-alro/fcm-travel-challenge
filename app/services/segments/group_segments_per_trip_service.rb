module Segments
  class GroupSegmentsPerTripService
    attr_reader :calculate_destination_city_service, :calculate_start_date_service, :trip_entity

    def initialize(base_city:,
                   ordered_segments:,
                   calculate_destination_city_service: Trips::CalculateDestinationCityService,
                   calculate_start_date_service: Trips::CalculateStartDateService,
                   trip_entity: TripEntity)
      @base_city = base_city
      @ordered_segments = ordered_segments
      @calculate_destination_city_service = calculate_destination_city_service
      @calculate_start_date_service = calculate_start_date_service
      @trip_entity = trip_entity
    end

    def call
      segments_grouped_by_trip.map do |segments_in_trip|
        destination_city = calculate_destination_city_service.call(base_city: base_city, segments: segments_in_trip)
        start_date = calculate_start_date_service.call(segments: segments_in_trip)

        trip_entity.new(destination_city: destination_city, start_date: start_date, segments: segments_in_trip)
      end
    end

    private

    attr_reader :base_city, :ordered_segments

    def segments_grouped_by_trip
      @segments_grouped_by_trip ||= ordered_segments.chunk_while { |segment_i, segment_j| segment_i.destination_city != base_city }.to_a
    end
  end
end
