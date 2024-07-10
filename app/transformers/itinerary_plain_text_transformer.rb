class ItineraryPlainTextTransformer
  TRIP_SEPARATOR = "\n\n"

  def self.call(trips:, trip_serializer: TripSerializer)
    trips.map { |trip| trip_serializer.new(trip).serializable_message }.join(TRIP_SEPARATOR)
  end
end
