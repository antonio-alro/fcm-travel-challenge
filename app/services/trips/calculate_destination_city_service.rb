module Trips
  class CalculateDestinationCityService
    def self.call(base_city:, segments:)
      involved_uniq_cities = segments.map { |segment| involved_cities_in_segment(segment: segment) }.flatten.uniq

      (involved_uniq_cities - [base_city]).last
    end

    private

    def self.involved_cities_in_segment(segment:)
      segment.slice(:origin_city, :destination_city).values
    end
  end
end
