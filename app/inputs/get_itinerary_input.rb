class GetItineraryInput
  attr_reader :base_city, :filename

  def initialize(base_city:, filename:)
    @base_city = base_city
    @filename = filename
  end
end
