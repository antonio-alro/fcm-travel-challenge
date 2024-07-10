module InputParser
  class GetSegmentsFromInputService
    attr_reader :folderpath, :file_manager, :file_not_found_error, :extract_segment_data_service

    def initialize(filename:,
                   folderpath: Pathname.new('/rails').join('lib', 'files'),
                   file_manager: File,
                   file_not_found_error: FileNotFoundError,
                   extract_segment_data_service: InputParser::ExtractSegmentDataService)
      @filename = filename
      @folderpath = folderpath
      @filepath = folderpath.join(filename)
      @file_manager = file_manager
      @file_not_found_error = file_not_found_error
      @extract_segment_data_service = extract_segment_data_service
    end

    def call
      raise file_not_found_error if !file_manager.exist?(filepath)

      segments = []

      file_manager.readlines(filepath).each do |line|
        segment = extract_segment_data_service.new(input_line: line).call

        next if segment.blank?

        segments << segment
      end

      segments
    end

    private

    attr_reader :filename, :filepath
  end
end
