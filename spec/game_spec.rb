require 'game'

describe Game do
  subject(:game) { Game.new }

  describe '#initialize' do
    it 'starts with a deck' do
      expect(game.deck).to be_a(Deck)
    end

    it 'starts with a full deck' do
      expect(game.deck.count).to eq(52)
    end

    it 'shuffles the deck'

    it 'accepts an array of names and initializes an array of Player instances'

    it 'initializes each Player with a hand of 7 cards with 3 or fewer players'

    it 'initializes each Player with a hand of 5 cards with 4 or more players'

    it 'sets the @current_player index to 0'
  end

  describe '#switch_players' do
    it 'increments the current_player index by one'

    it 'does not go out of bounds of the @players array'
  end

  describe "#check_players_out" do
    it 'removes all players with empty hands from the @players array'

    it 'does not remove players that do not have empty hands'
  end

  describe '#game_over?' do
    it 'returns false when the deck is not empty'

    it 'returns false when the deck is empty but players still have cards'

    it 'returns true when the deck is empty and no players have any cards'
  end

  describe '#winner' do
    it 'returns the player with the most completed books'
  end
end
