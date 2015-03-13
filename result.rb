class Result

  def initialize(expectation:, assertion:)
    @expectation = expectation
    @assertion = assertion
  end

  def message
    failure_message unless success?
  end

  def success?
    expectation == assertion
  end

  private

  attr_reader :assertion, :expectation

  def failure_message
    "  - #{expectation} does not equal #{assertion}."
  end

end
