require 'game'

describe Game do
  subject(:game) { Game.new }

  describe '#initialize' do
    it 'should'
  end

  describe '#deck' do
    it 'should start with a deck' do
      expect(game.deck).to be_a(Deck)
    end

    it 'should start with a full deck' do
      expect(game.deck.count).to eq(52)
    end
  end

  describe '#game_over?' do
    it 'should return false when the deck is not empty' do
    end

    it 'should return false when the deck is empty but players still have cards' do
    end

    it 'should return true when the deck is empty and no players have any cards' do
    end
  end

end
