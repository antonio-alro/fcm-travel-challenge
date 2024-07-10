class TripSerializer < BaseSerializer
  LINE_SEPARATOR = "\n"

  attr_reader :segment_serializer

  def initialize(object, segment_serializer: SegmentSerializer)
    @segment_serializer = segment_serializer
    super(object)
  end

  def serializable_message
    output_lines = []

    output_lines << trip_message

    object.segments.map do |segment|
      output_lines << segment_serializer.new(segment).serializable_message
    end

    output_lines.join(LINE_SEPARATOR)
  end

  private

  def trip_message
    I18n.t("trips.label", destination: object.destination_city)
  end
end
