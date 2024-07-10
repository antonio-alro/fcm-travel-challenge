class GetItineraryUseCase
  attr_reader :get_segments_from_input_service, :order_segments_service, :group_segments_per_trip_service

  def initialize(get_segments_from_input_service: InputParser::GetSegmentsFromInputService,
                 order_segments_service: InputParser::OrderSegmentsService,
                 group_segments_per_trip_service: Segments::GroupSegmentsPerTripService)
    @get_segments_from_input_service = get_segments_from_input_service
    @order_segments_service = order_segments_service
    @group_segments_per_trip_service = group_segments_per_trip_service
  end

  def perform(input:)
    # Get segments from the input file
    segments = get_segments_from_input_service.new(filename: input.filename).call

    # Order those segments by start date
    ordered_segments = order_segments_service.call(segments: segments)

    # Group the ordered segments per trip
    trips = group_segments_per_trip_service.new(base_city: input.base_city, ordered_segments: ordered_segments).call

    trips
  end
end
