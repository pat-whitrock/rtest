require 'spec_helper'

RSpec.describe RTest do
  describe '.describe' do
    let(:example_group) { double(instance_eval: nil) }
    let(:message) { 'SomeClass' }

    it 'instantiates a new ExampleGroup' do
      expect(ExampleGroup).to receive(:new).with(message).and_return(example_group)
      RTest.describe(message) { message }
    end

    it 'evaluates the block against the ExampleGroup' do
      allow(ExampleGroup).to receive(:new).with(message).and_return(example_group)
      expect(example_group).to receive(:instance_eval).once
      RTest.describe(message) { self.class }
    end
  end
end
