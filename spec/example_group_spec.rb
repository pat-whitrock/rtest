require 'spec_helper'

RSpec.describe ExampleGroup do
  let!(:example_group) { ExampleGroup.new(message) }
  let(:message) { 'SomeClass' }

  describe '#context' do
    it 'is an alias of #define_example_group' do
      expect(example_group.method(:context)).to eq(example_group.method(:define_example_group))
    end
  end

  describe '#define_example_group' do
    let(:amended_message) { "#{message} #{description}" }
    let(:amended_example_group) { double(instance_eval: nil) }
    let(:description) { 'SomeMethod' }

    it 'instantiates a new ExampleGroup' do
      expect(ExampleGroup).to receive(:new).with(amended_message).and_return(amended_example_group)
      example_group.define_example_group(description) { self.class }
    end

    it 'evaluates the block against the ExampleGroup' do
      allow(ExampleGroup).to receive(:new).with(amended_message).and_return(amended_example_group)
      expect(amended_example_group).to receive(:instance_eval).once
      example_group.define_example_group(description) { self.class }
    end
  end

  describe '#describe' do
    it 'is an alias of #define_example_group' do
      expect(example_group.method(:describe)).to eq(example_group.method(:define_example_group))
    end
  end

  describe '#it' do
    let(:amended_message) { "#{message} #{description}" }
    let(:test) { double(run: nil) }
    let(:description) { 'SomeMethod' }

    it 'instantiates a new Test' do
      expect(Test).to receive(:new).with(amended_message).and_return(test)
      example_group.it(description) { self.class }
    end

    it 'runs the block against the ExampleGroup' do
      allow(Test).to receive(:new).with(amended_message).and_return(test)
      expect(test).to receive(:run).once
      example_group.it(description) { self.class }
    end
  end
end
