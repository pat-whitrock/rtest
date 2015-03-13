class Expectation
  attr_reader :result

  def initialize(value)
    @value = value
  end

  def to(assertion)
    @result = Result.new(expectation: value, assertion: assertion.value)
  end

  private

  attr_reader :value

end
