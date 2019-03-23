require 'card'

describe Card do
  describe '#initialize' do
    subject(:card) { Card.new(:spades, :ten) }

    it 'sets up a card correctly' do
      expect(card.suit).to eq(:spades)
      expect(card.value).to eq(:ten)
    end

    it 'raises an error with an invalid suit' do
      expect do
        Card.new(:test, :ten)
      end.to raise_error
    end

    it 'raises an error with an invalid value' do
      expect do
        Card.new(:spades, :test)
      end.to raise_error
    end
  end

end
