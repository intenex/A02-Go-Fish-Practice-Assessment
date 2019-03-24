require '00_card'
require '02_hand'
require '03_player'
require '04_game'

describe Player do
  subject(:player) do
    Player.new("Alice")
  end

  describe "#initialize" do
    it "assigns the name" do
      expect(player.name).to eq("Alice")
    end

    it "sets the number of @books to 0" do
      expect(player.books).to be(0)
    end

    it "sets @turn_over to false" do
      expect(player.turn_over).to be(false)
    end
  end

  describe "#opponent_prompt" do 
    opponents = [Player.new("Bob"), Player.new("Charlie"), Player.new("Daisy")]
    it "asks the user for a target player to get cards from" do
      expect(player).to receive(:gets).and_return("0\n")
      player.opponent_prompt(opponents)
    end

    it "raises an error when an invalid target player index is chosen" do
      allow(player).to receive(:gets).and_return("4\n")
      expect { player.opponent_prompt(opponents) }.to raise_error("That was not a valid choice. Try again.")
    end
  end

  describe "#rank_prompt" do
    opponent = Player.new("Bob")
    player_cards = [
      Card.new(:hearts, :four),
      Card.new(:hearts, :three),
      Card.new(:diamonds, :seven),
      Card.new(:spades, :jack),
      Card.new(:clubs, :king)
    ]
    opponent_cards = [
      Card.new(:hearts, :deuce),
      Card.new(:diamonds, :three),
      Card.new(:clubs, :three),
      Card.new(:spades, :four),
      Card.new(:hearts, :ace)
    ]
    opponent.instance_variable_set(:@hand, Hand.new(opponent_cards))
    it "asks the user for a rank of card to fish for" do
      player.instance_variable_set(:@hand, Hand.new(player_cards))
      expect(player).to receive(:gets).and_return("3\n")
      player.rank_prompt(opponent)
    end

    it "raises an error when a player specifies an invalid rank of card" do
      player.instance_variable_set(:@hand, Hand.new(player_cards))
      allow(player).to receive(:gets).and_return("15\n")
      expect { player.rank_prompt(opponent) }.to raise_error("Invalid rank. Try again.")
    end
  end

  describe "#go_fish" do
    let(:deck) { double("deck") }
    let(:card) { double("card") }
    let(:hand) { double("hand") }
    it "takes one card from the deck and adds it to the player's hand" do
      player.hand = hand
      expect(deck).to receive(:empty?).and_return(false)
      expect(deck).to receive(:take).with(1).and_return([card])
      expect(hand).to receive(:add_cards).with([card])
      expect(hand).to receive(:book?).and_return(false)
      player.go_fish(deck)
    end

    it "checks to see if a book is completed and increments @books if so" do
      player.hand = hand
      expect(deck).to receive(:empty?).and_return(false)
      expect(deck).to receive(:take).with(1).and_return([card])
      expect(hand).to receive(:add_cards).with([card])
      expect(hand).to receive(:book?).and_return(true)
      expect(hand).to receive(:remove_book)
      player.go_fish(deck)
      expect(player.books).to be(1)
    end

    it "does nothing when the deck is empty" do
      player.hand = hand
      expect(deck).to receive(:empty?).and_return(true)
      expect(deck).not_to receive(:take)
      expect(hand).not_to receive(:add_cards)
      expect(hand).not_to receive(:book?)
      expect(hand).not_to receive(:remove_book)
      player.go_fish(deck)
    end
  end

  describe "#get_cards" do
    let(:card) { double("card") }
    let(:hand) { double("hand") }
    it "removes all cards of the specified value from the player's hand" do
      player.hand = hand
      expect(hand).to receive(:remove_cards).with(:deuce)
      player.get_cards(:deuce)
    end
  end

  describe "#turn_over?" do
    opponent = Player.new("Bob")
    player_cards = [
      Card.new(:hearts, :four),
      Card.new(:hearts, :three),
      Card.new(:diamonds, :seven),
      Card.new(:spades, :jack),
      Card.new(:clubs, :king)
    ]
    opponent_cards = [
      Card.new(:hearts, :deuce),
      Card.new(:diamonds, :three),
      Card.new(:clubs, :three),
      Card.new(:spades, :four),
      Card.new(:hearts, :ace)
    ]
    opponent.instance_variable_set(:@hand, Hand.new(opponent_cards))
    it "returns true if the player has failed a catch" do
      player.instance_variable_set(:@hand, Hand.new(player_cards))
      expect(player).to receive(:gets).and_return("7\n")
      player.rank_prompt(opponent)
      expect(player.turn_over?).to be(true)
    end

    it "returns false if the player has successfully made a catch" do
      player.instance_variable_set(:@hand, Hand.new(player_cards))
      expect(player).to receive(:gets).and_return("3\n")
      player.rank_prompt(opponent)
      expect(player.turn_over?).to be(false)
    end
  end

  describe "#request_cards" do
    game = Game.new("Alice", "Bob", "Charlie")
    alice = game.players.first
    charlie = game.players.last
    it "calls #opponent_prompt and passes in an array of opponent players" do
      expect(charlie).to receive(:opponent_prompt).with(game.players - [charlie]).and_return(game.players.first)
      expect(charlie).to receive(:rank_prompt)
      charlie.request_cards(game.players - [charlie])
    end

    it "calls #rank_prompt and passes in the target player" do
      expect(alice).to receive(:opponent_prompt).with(game.players - [alice]).and_return(game.players.last)
      expect(alice).to receive(:rank_prompt).with(game.players.last)
      alice.request_cards(game.players - [alice])
    end
  end

  describe "#reset_turn" do
    it "causes #turn_over? to return false" do
      player.instance_variable_set(:@turn_over, true)
      player.reset_turn
      expect(player.turn_over?).to be(false)
    end
  end
end