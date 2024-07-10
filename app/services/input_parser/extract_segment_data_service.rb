module InputParser
  class ExtractSegmentDataService
    ACCOMMODATION_REGEXP = /SEGMENT: ([a-zA-Z]+) ([A-Z]{3}) (\d{4}-\d{2}-\d{2}) -> (\d{4}-\d{2}-\d{2})/.freeze
    TRIP_REGEXP = /SEGMENT: ([a-zA-Z]+) ([A-Z]{3}) ((\d{4}-\d{2}-\d{2}) \d{2}:\d{2}) -> ([A-Z]{3}) (\d{2}:\d{2})/.freeze

    attr_reader :segment_factory

    def initialize(input_line:, segment_factory: DomainFactories::SegmentFactory)
      @input_line = input_line
      @segment_factory = segment_factory
    end

    def call
      return if input_line.blank?

      if input_line.match?(ACCOMMODATION_REGEXP)
        captures = input_line.match(ACCOMMODATION_REGEXP).captures
        segment_factory.initialize_segment_for_accomodation(captures)
      elsif input_line.match?(TRIP_REGEXP)
        captures = input_line.match(TRIP_REGEXP).captures
        segment_factory.initialize_segment_for_transport(captures)
      end
    end

    private

    attr_reader :input_line
  end
end
