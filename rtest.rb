class RTest
  def self.describe(message, &block)
    ExampleGroup.new(message).instance_eval(&block)
  end
end
