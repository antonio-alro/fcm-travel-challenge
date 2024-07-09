# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InputParser::GetSegmentsFromInputService, type: :service do
  subject(:service) { described_class.new(input_line: input_line) }

  # context 'without an input_line' do
  #   let(:input_line) { nil }

  #   it 'returns nothing' do
  #     expect(subject.call).to be_nil
  #   end
  # end

  describe '#call' do
    it 'returns the segments ordered by date' do
      input_line = ['SEGMENT: Flight SVQ 2023-03-02 06:40 -> BCN 09:10']
      segment_data = {
        kind: 'flight',
        origin_city: 'SVQ',
        destination_city: 'BCN',
        starts_at: DateTime.parse('2023-03-02 06:40'),
        ends_at: DateTime.parse('2023-03-02 09:10')
      }
      service = described_class.new(
        filename: 'input.txt',
        folderpath: Rails.root.join('lib', 'files'),
        file_manager: self.class::FakeFileManager.with_lines([input_line]),
        extract_segment_data_service: self.class::FakeExtractSegmentDataService.with_segment_data(segment_data)
      )
      filepath = service.folderpath.join('input.txt')

      expect(service.file_manager).to receive(:readlines).with(filepath).and_call_original
      expect(service.extract_segment_data_service).to receive(:new).with(input_line: input_line).and_call_original

      result = service.call

      expect(result).to eq([segment_data])
    end
  end

  class self::FakeFileManager
    attr_reader :lines

    def self.with_lines(lines)
      @@lines = lines
      self
    end

    def self.readlines(*)
      @@lines
    end
  end

  class self::FakeExtractSegmentDataService
    attr_reader :segment_data

    def self.with_segment_data(segment_data)
      @@segment_data = segment_data
      self
    end

    def initialize(*)
      self
    end

    def call(*)
      @@segment_data
    end
  end
end
