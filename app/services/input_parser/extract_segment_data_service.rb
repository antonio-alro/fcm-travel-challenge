module InputParser
  class ExtractSegmentDataService
    ACCOMMODATION_REGEXP = /SEGMENT: ([a-zA-Z]+) ([A-Z]{3}) (\d{4}-\d{2}-\d{2}) -> (\d{4}-\d{2}-\d{2})/.freeze
    TRIP_REGEXP = /SEGMENT: ([a-zA-Z]+) ([A-Z]{3}) ((\d{4}-\d{2}-\d{2}) \d{2}:\d{2}) -> ([A-Z]{3}) (\d{2}:\d{2})/.freeze

    attr_reader :accomodation_kinds, :trip_kinds

    def initialize(input_line:, accomodation_kinds: SegmentEntity::ACCOMMODATION_KINDS, trip_kinds: SegmentEntity::TRIP_KINDS)
      @input_line = input_line
      @accomodation_kinds = accomodation_kinds
      @trip_kinds = trip_kinds
    end

    def call
      return if input_line.blank?

      if input_line.match?(ACCOMMODATION_REGEXP)
        captures = input_line.match(ACCOMMODATION_REGEXP).captures
        segment_data_for_accommodation_captures(captures)
      elsif input_line.match?(TRIP_REGEXP)
        captures = input_line.match(TRIP_REGEXP).captures
        segment_data_for_trip_captures(captures)
      else
        {}
      end
    end

    private

    attr_reader :input_line

    def segment_data_for_accommodation_captures(captures)
      {
        kind: accomodation_kinds.invert[captures[0]],
        origin_city: captures[1],
        destination_city: captures[1],
        starts_at: Date.parse(captures[2]).end_of_day,
        ends_at: Date.parse(captures[3]).beginning_of_day
      }
    end

    def segment_data_for_trip_captures(captures)
      {
        kind: trip_kinds.invert[captures[0]],
        origin_city: captures[1],
        destination_city: captures[4],
        starts_at: DateTime.parse(captures[2]),
        ends_at: DateTime.parse("#{captures[3]} #{captures[5]}")#,
        #return_trip: user.based_on == captures[4]
      }
    end
  end
end
