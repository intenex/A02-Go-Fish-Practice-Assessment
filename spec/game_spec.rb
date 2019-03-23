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
    it 'should return false when players still have money' do
      game.add_players(5, 100)
      expect(game).not_to be_game_over
    end

    it 'should return true when all but one player has no more money' do
      game.add_players(5, 0)
      game.add_players(1, 100)
      expect(game).to be_game_over
    end
  end

  describe '#deal_cards' do
    before(:each) do
      game.add_players(5, 100)
    end

    it 'should give each player a full hand' do
      game.deal_cards
      expect(
        game.players.all? { |player| player.hand }
      ).to be(true)
    end

    it 'should not give a player a hand if the player has no money' do
      game.add_players(1, 0)
      game.deal_cards
      expect(game.players.last.hand).to be_nil
    end
  end

end
