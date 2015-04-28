require 'delegate'

class FakeSocket < SimpleDelegator
  def initialize
    @buffer = StringIO.new
    super(@buffer)
  end

  def written_value
    @buffer.rewind
    @buffer.read
  end
end
