require 'spec_helper'
require 'active_support/core_ext/kernel/reporting'

RSpec.describe Test do
  let(:message) { 'some message' }
  let(:test) { Test.new(message) }

  describe '#eq' do
    let(:value) { 'some value' }

    it 'instantiates a new Assertion with the value' do
      expect(Assertion).to receive(:new).with(value)
      test.eq(value)
    end
  end

  describe '#expect' do
    let(:expectation) { instance_double(Expectation) }
    let(:value) { 'some value' }
    before { allow(Expectation).to receive(:new).with(value).and_return(expectation) }

    it 'returns a new expectation with the value' do
      expect(test.expect(value)).to eq(expectation)
    end

    it 'pushes the expectation into the @expectations' do
      expect { test.expect(value) }.to change {
        test.instance_variable_get(:@expectations)
      }.from([]).to([expectation])
    end
  end

  describe '#run' do
    it 'evaluates the block against itself' do
      expect(test).to receive(:instance_eval).once
      test.run { self.class }
    end

    context 'when all results pass' do
      let(:expectations) { [instance_double(Expectation, result: result)] }
      let(:result) { instance_double(Result, success?: true) }
      before do
        allow(test).to receive(:instance_eval)
        test.instance_variable_set(:@expectations, expectations)
      end

      it 'prints the success message' do
        output = capture(:stdout) do
          test.run
        end
        expect(output).to include("PASSED: #{message}")
      end
    end

    context 'when one or more results fail' do
      let(:expectation) { ->(message) { instance_double(Expectation, result: result.(message)) } }
      let(:expectations) { [expectation.(first_message), expectation.(second_message)] }
      let(:first_message) { 'first message' }
      let(:result) { ->(message) { instance_double(Result, success?: false, message: message) } }
      let(:second_message) { 'second message' }
      before do
        allow(test).to receive(:instance_eval)
        test.instance_variable_set(:@expectations, expectations)
      end

      it 'prints the failure message' do
        output = capture(:stdout) do
          test.run
        end
        expect(output).to include("FAILED: #{message}")
      end

      it 'prints the message for each failed result' do
        output = capture(:stdout) do
          test.run
        end
        expect(output).to include(first_message, second_message)
      end
    end

    context 'when one or more results fail and one or more results pass' do
      let(:expectation) do
        ->(success, message) { instance_double(Expectation, result: result.(success, message)) }
      end
      let(:expectations) do
        [expectation.(true, passed_message), expectation.(false, failed_message)]
      end
      let(:passed_message) { 'passed message' }
      let(:result) do
        ->(success, message) { instance_double(Result, success?: success, message: message) }
      end
      let(:failed_message) { 'failed message' }
      before do
        allow(test).to receive(:instance_eval)
        test.instance_variable_set(:@expectations, expectations)
      end

      it 'prints the failure message' do
        output = capture(:stdout) do
          test.run
        end
        expect(output).to include("FAILED: #{message}")
      end

      it 'does not print the message for any passed results' do
        output = capture(:stdout) do
          test.run
        end
        expect(output).not_to include(passed_message)
      end

      it 'prints the message for each failed result' do
        output = capture(:stdout) do
          test.run
        end
        expect(output).to include(failed_message)
      end
    end
  end
end
