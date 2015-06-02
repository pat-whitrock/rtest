class Result
  def initialize(asserted_value:, expected_value:)
    @asserted_value = asserted_value
    @expected_value = expected_value
  end

  def message
    failure_message unless success?
  end

  def success?
    expected_value == asserted_value
  end

  private

  attr_reader :asserted_value, :expected_value

  def failure_message
    "  - #{expected_value} does not equal #{asserted_value}."
  end
end
