require 'rails_helper'

RSpec.describe 'Main script', type: :script do
  it 'returns the expected output given the input' do
    input = GetItineraryInput.new(base_city: 'SVQ', filename: 'input.txt')
    trips = GetItineraryUseCase.new.perform(input: input)
    output_message = ItineraryPlainTextTransformer.call(trips: trips)

    expected_output_message = begin
      "TRIP to BCN\n"\
      "Flight from SVQ to BCN at 2023-01-05 20:40 to 22:10\n"\
      "Hotel at BCN on 2023-01-05 to 2023-01-10\n"\
      "Flight from BCN to SVQ at 2023-01-10 10:30 to 11:50\n"\
      "\n"\
      "TRIP to MAD\n"\
      "Train from SVQ to MAD at 2023-02-15 09:30 to 11:00\n"\
      "Hotel at MAD on 2023-02-15 to 2023-02-17\n"\
      "Train from MAD to SVQ at 2023-02-17 17:00 to 19:30\n"\
      "\n"\
      "TRIP to NYC\n"\
      "Flight from SVQ to BCN at 2023-03-02 06:40 to 09:10\n"\
      "Flight from BCN to NYC at 2023-03-02 15:00 to 22:45"
    end

    expect(output_message).to eq(expected_output_message)
  end
end
