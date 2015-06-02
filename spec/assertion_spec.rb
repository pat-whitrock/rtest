require 'spec_helper'

RSpec.describe Assertion do
  let(:assertion) { Assertion.new(value) }
  let(:value) { 'some value' }

  describe '#value' do
    it 'returns the value it was instantiated with' do
      expect(assertion.value).to eq(value)
    end
  end
end
