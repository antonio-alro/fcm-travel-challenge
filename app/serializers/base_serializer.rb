class BaseSerializer
  def initialize(object)
    @object = object
  end

  def serializable_message
    raise NotImplementedError
  end

  private

  attr_reader :object
end
