require 'spec_helper'

RSpec.describe Expectation do
  let(:expectation) { Expectation.new(value) }
  let(:value) { 'expected value' }

  describe '#result' do
    let(:result) { instance_double(Result) }
    before { expectation.instance_variable_set(:@result, result) }

    it 'returns @result' do
      expect(expectation.result).to eq(result)
    end
  end

  describe '#to' do
    let(:assertion) { instance_double(Assertion, value: 'actual value') }
    let(:result) { instance_double(Result) }
    before do
      allow(Result).to receive(:new).with(
        expected_value: value,
        asserted_value: assertion.value
      ).and_return(result)
    end

    it 'returns a newly instantiated result' do
      expect(expectation.to(assertion)).to eq(result)
    end

    it 'sets @result' do
      expect { expectation.to(assertion) }.to change {
        expectation.instance_variable_get(:@result)
      }.from(nil).to(result)
    end
  end
end
