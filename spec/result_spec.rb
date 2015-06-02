require 'spec_helper'

RSpec.describe Result do
  describe '#message' do
    context 'when expected and asserted values are equal' do
      let(:result) { Result.new(asserted_value: value, expected_value: value) }
      let(:value) { 'some value' }

      it 'returns nil' do
        expect(result.message).to eq nil
      end
    end

    context 'when expected and asserted values are not equal' do
      let(:asserted_value) { 'asserted value' }
      let(:expected_value) { 'expected value' }
      let(:result) do
        Result.new(asserted_value: asserted_value, expected_value: expected_value)
      end

      it 'returns the failure message' do
        expect(result.message).to eq "  - #{expected_value} does not equal #{asserted_value}."
      end
    end
  end

  describe '#success?' do
    context 'when the expected and asserted values are equal' do
      let(:result) { Result.new(asserted_value: value, expected_value: value) }
      let(:value) { 'some value' }

      it 'returns true' do
        expect(result.success?).to eq(true)
      end
    end

    context 'when the expected and asserted values are not equal' do
      let(:asserted_value) { 'asserted value' }
      let(:expected_value) { 'expected value' }
      let(:result) do
        Result.new(asserted_value: asserted_value, expected_value: expected_value)
      end

      it 'returns false' do
        expect(result.success?).to eq(false)
      end
    end
  end
end
