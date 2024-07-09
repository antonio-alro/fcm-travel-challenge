module Trips
  class CalculateStartDateService
    def self.call(segments:)
      segments.first.dig(:starts_at).to_date
    end
  end
end
