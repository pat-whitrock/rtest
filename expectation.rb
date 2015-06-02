class Expectation
  attr_reader :result

  def initialize(value)
    @value = value
  end

  def to(assertion)
    @result = Result.new(expected_value: value, asserted_value: assertion.value)
  end

  private

  attr_reader :value
end
