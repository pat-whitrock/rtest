require_relative './assertion.rb'
require_relative './example_group.rb'
require_relative './expectation.rb'
require_relative './result.rb'
require_relative './rtest.rb'
require_relative './test.rb'

RTest.describe 'String' do
  describe '#empty?' do
    context 'when containing 0 characters' do
      it 'returns true' do
        expect(''.empty?).to eq true
      end
    end

    context 'when containing more than 1 character' do
      it 'returns false' do
        expect('Hello world'.empty?).to eq true
      end
    end
  end
end
