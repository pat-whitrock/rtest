class ExampleGroup

  def initialize(message)
    @message = message
  end

  def define_example_group(description, &block)
    new(amended_message(description)).instance_eval(&block)
  end
  [:context, :describe].each { |meth| alias_method meth, :define_example_group }

  def it(description, &block)
    Test.new(amended_message(description)).run(&block)
  end

  private

  attr_reader :message

  def amended_message(description)
    "#{message} #{description}"
  end

end
