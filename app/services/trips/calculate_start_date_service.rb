module Trips
  class CalculateStartDateService
    def self.call(segments:)
      segments.first.starts_at.to_date
    end
  end
end
