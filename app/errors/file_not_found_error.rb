class FileNotFoundError < BaseError
  def initialize(message: 'The input file has not been found!')
    super(message: message)
  end
end
