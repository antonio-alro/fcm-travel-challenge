module InputParser
  class OrderSegmentsService
    def self.call(segments:)
      segments.sort_by { |segment| segment.starts_at }
    end
  end
end
