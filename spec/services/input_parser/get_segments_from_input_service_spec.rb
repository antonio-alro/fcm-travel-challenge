require 'rails_helper'

RSpec.describe InputParser::GetSegmentsFromInputService, type: :service do
  describe '#call' do
    context 'when the file does not exist' do
      it 'raises an error' do
        service = described_class.new(
          filename: 'input.txt',
          file_manager: self.class::FakeNotFoundFileManager
        )
        filepath = service.folderpath.join('input.txt')

        expect(service.file_manager).to receive(:exist?).and_call_original
        expect(service.file_manager).not_to receive(:readlines)
        expect(service.extract_segment_data_service).not_to receive(:new)

        expect { service.call }.to raise_error(service.file_not_found_error)
      end
    end

    context 'when the file exist' do
      it 'returns the segments ordered by date' do
        input_line = ['SEGMENT: Flight SVQ 2023-03-02 06:40 -> BCN 09:10']
        segment = SegmentEntity.new(
          kind: 'flight',
          origin_city: 'SVQ',
          destination_city: 'BCN',
          starts_at: DateTime.parse('2023-03-02 06:40'),
          ends_at: DateTime.parse('2023-03-02 09:10')
        )
        service = described_class.new(
          filename: 'input.txt',
          file_manager: self.class::FakeFileManager.with_lines([input_line]),
          extract_segment_data_service: self.class::FakeExtractSegmentDataService.with_segment(segment)
        )
        filepath = service.folderpath.join('input.txt')

        expect(service.file_manager).to receive(:readlines).with(filepath).and_call_original
        expect(service.extract_segment_data_service).to receive(:new).with(input_line: input_line).and_call_original

        result = service.call

        expect(result).to eq([segment])
      end
    end
  end

  class self::FakeNotFoundFileManager
    def self.exist?(*)
      false
    end
  end

  class self::FakeFileManager
    attr_reader :lines

    def self.with_lines(lines)
      @@lines = lines
      self
    end

    def self.exist?(*)
      true
    end

    def self.readlines(*)
      @@lines
    end
  end

  class self::FakeExtractSegmentDataService
    attr_reader :segment

    def self.with_segment(segment)
      @@segment = segment
      self
    end

    def initialize(*)
      self
    end

    def call(*)
      @@segment
    end
  end
end
