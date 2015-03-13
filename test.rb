class Test

  def initialize(message)
    @message = message
    @expectations = []
  end

  def eq(value)
    Assertion.new(value)
  end

  def expect(value)
    expectation = Expectation.new(value)
    expectations << expectation
    expectation
  end

  def run(&block)
    instance_eval(&block)

    if results.all?(&:success?)
      puts "PASSED: #{message}"
    else
      puts "FAILED: #{message}"
      failed_results.each { |result| puts result.message }
    end
  end

  private

  attr_reader :expectations, :message

  def failed_results
    results.reject(&:success?)
  end

  def results
    expectations.map(&:result)
  end

end
