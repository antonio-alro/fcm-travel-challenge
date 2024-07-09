module InputParser
  class GetSegmentsFromInputService
    attr_reader :folderpath, :file_manager, :extract_segment_data_service

    def initialize(filename:,
                   folderpath: Rails.root.join('lib', 'files'),
                   file_manager: File,
                   extract_segment_data_service: InputParser::ExtractSegmentDataService)
      @filename = filename
      @folderpath = folderpath
      @filepath = folderpath.join(filename)
      @file_manager = file_manager
      @extract_segment_data_service = extract_segment_data_service
    end

    def call
      segments = []

      file_manager.readlines(filepath).each do |line|
        segment_data = extract_segment_data_service.new(input_line: line).call

        next if segment_data.blank?

        segments << segment_data
      end

      segments
    end

    private

    attr_reader :filename, :filepath
  end
end
