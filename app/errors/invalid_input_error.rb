class InvalidInputError < BaseError
  def initialize(message: 'The input if not valid! Check the arguments!')
    super(message: message)
  end
end
