#!/usr/bin/env ruby

=begin
  Example of how to run this script:
    BASED=SVQ bundle exec ruby main.rb input.txt
=end

require 'active_support'
require 'active_support/core_ext'
require 'i18n'

# Load the code of our application
paths_to_load = [
  "./app/inputs/**/*.rb",
  "./app/entities/**/*.rb",
  "./app/errors/**/*.rb",
  "./app/serializers/**/*.rb",
  "./app/transformers/**/*.rb",
  "./app/services/**/*.rb",
  "./app/use_cases/**/*.rb"
]
Dir[*paths_to_load].each { |file| require file }

# I18n config
def set_i18n_config
  I18n.load_path += Dir[Pathname.new('/rails').join('config', 'locales', '**/*.{rb,yml}')]
  I18n.default_locale = :en
  I18n.available_locales = [:en]
end

# Set the necessary config
set_i18n_config

# Get the script arguments
filename = ARGV[0]
base_city = ENV['BASED']

# Call the use case to get the itinerary
input = GetItineraryInput.new(base_city: base_city, filename: filename)
trips = GetItineraryUseCase.new.perform(input: input)

# Call the transformer to get the expected plain text response
output_message = ItineraryPlainTextTransformer.call(trips: trips)

# Print the output
puts output_message

