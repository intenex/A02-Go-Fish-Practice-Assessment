require '00_card'
require '04_game'

describe Game do
  describe '#initialize' do
    it 'starts with a deck' do
      game = Game.new
      expect(game.deck).to be_a(Deck)
    end

    it 'starts with a full deck' do
      game = Game.new
      expect(game.deck.count).to eq(52)
    end

    it 'shuffles the deck' do
      game = Game.new
      cards = game.deck.instance_variable_get(:@cards)
      sorted_cards = cards.sort_by { |card| Card.values.index(card.value) }
      expect(cards).to match_array(sorted_cards)
      expect(cards).not_to eq(sorted_cards)
    end

    it 'accepts an array of names and initializes an array of Player instances' do
      game = Game.new("Alice", "Bob", "Charlie", "Daisy")
      expect(game.players.length).to eq(4)
      expect(game.players[0]).to be_a(Player)
    end

    it 'initializes each Player with a hand of 7 cards with 3 or fewer players' do
      game = Game.new("Alice", "Bob", "Charlie")
      expect(game.players[0].hand.cards.size).to be(7)
    end

    it 'initializes each Player with a hand of 5 cards with 4 or more players' do
      game = Game.new("Alice", "Bob", "Charlie", "Daisy")
      expect(game.players[0].hand.cards.size).to be(5)
    end

    it 'sets the @current_player index to 0' do
      game = Game.new("Alice", "Bob", "Charlie")
      expect(game.current_player).to be(0)
    end
  end

  describe '#switch_players' do
    subject(:game) { Game.new("Alice", "Bob", "Charlie") }
    it 'increments the current_player index by one' do
      game.switch_players
      expect(game.current_player).to be(1)
    end

    it 'does not go out of bounds of the @players array' do
      expect(game.current_player).to be(0)
      game.switch_players
      expect(game.current_player).to be(1)
      game.switch_players
      expect(game.current_player).to be(2)
      game.switch_players
      expect(game.current_player).to be(0)
    end
  end

  describe "#check_players_out" do
    it 'removes players with empty hands from the @players array' do
      game = Game.new("Alice", "Bob", "Charlie")
      expect(game.players.size).to be(3)
      game.players[0].hand.instance_variable_set(:@cards, [])
      game.check_players_out
      expect(game.players.size).to be(2)
      game.players[1].hand.instance_variable_set(:@cards, [])
      game.check_players_out
      expect(game.players.size).to be(1)
    end

    it 'does not remove players that do not have empty hands' do
      game = Game.new("Alice", "Bob", "Charlie")
      game.check_players_out
      expect(game.players.size).to be(3)
    end
  end

  describe '#game_over?' do
    it 'returns false when the deck is not empty' do
      game = Game.new("Alice", "Bob", "Charlie")
      expect(game.game_over?).to be(false)
    end

    it 'returns false when the deck is empty but players still have cards' do
      game = Game.new("Alice", "Bob", "Charlie", "Daisy")
      game.deck.take(32)
      expect(game.deck.empty?).to be(true)
      expect(game.game_over?).to be(false)
    end

    it 'returns true when the deck is empty and no players have any cards' do
      game = Game.new("Alice", "Bob")
      game.deck.take(38)
      expect(game.deck.empty?).to be(true)
      game.players[0].hand.instance_variable_set(:@cards, [])
      expect(game.game_over?).to be(false)
      game.players[1].hand.instance_variable_set(:@cards, [])
      expect(game.game_over?).to be(true)
    end
  end

  describe '#winner' do
    it 'returns the player with the most completed books' do
      game = Game.new("Alice", "Bob", "Charlie")
      game.players[0].instance_variable_set(:@books, 2)
      expect(game.winner).to eq(game.players[0])
      game.players[1].instance_variable_set(:@books, 3)
      expect(game.winner).to eq(game.players[1])
      game.players[2].instance_variable_set(:@books, 1)
      expect(game.winner).to eq(game.players[1])
      game.players[2].instance_variable_set(:@books, 5)
      expect(game.winner).to eq(game.players[2])
    end
  end

  describe "#play_turn" do
    before(:each) do
      @game = Game.new("Alice", "Bob")
      expect(@game.players.first).to receive(:request_cards).twice
      expect(@game.players.first).to receive(:turn_over?).and_return(false, false, true)
    end

    it 'calls #request_cards on the current player until their turn is over' do
      @game.play_turn
    end

    it "calls Player#reset_turn after their turn is over" do
      expect(@game.players.first).to receive(:reset_turn).once
      @game.play_turn
    end

    it "calls Player#go_fish after their turn is over" do
      expect(@game.players.first).to receive(:go_fish).once
      @game.play_turn
    end

    it "switches players after a turn is over" do
      expect(@game.current_player).to be(0)
      @game.play_turn
      expect(@game.current_player).to be(1)
    end

    it "removes players from the game if the deck is empty and a player has no cards" do
      expect(@game.deck).to receive(:empty?).and_return(true, true, true)
      expect(@game.players.first.hand).to receive(:empty?).and_return(true, true)
      @game.play_turn
      expect(@game.players.size).to be(1)
      expect(@game.players.first.name).to eq("Bob")
    end
  end

  describe "#play" do
    game = Game.new("Alice", "Bob")
    it "calls #play_turn until the game is over" do
      expect(game).to receive(:play_turn).exactly(3).times
      expect(game).to receive(:game_over?).and_return(false, false, false, true)
      game.play
    end
  end
end