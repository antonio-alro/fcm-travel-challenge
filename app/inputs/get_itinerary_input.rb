class GetItineraryInput
  attr_reader :base_city, :filename, :invalid_input_error

  def initialize(base_city:, filename:, invalid_input_error: InvalidInputError)
    @base_city = base_city
    @filename = filename
    @invalid_input_error = invalid_input_error
  end

  def invalid?
    !valid?
  end

  private

  def valid?
    base_city.present? && filename.present?
  end
end
