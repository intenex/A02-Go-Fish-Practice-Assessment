require 'player'

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

  describe "#request_cards" do # hard to test input, maybe just leave these in as givens
  # actually sounds like total bullshit seems totally trivial to test what are they talking about
  # https://stackoverflow.com/questions/23349863/testing-stdin-in-ruby

    it "asks the user for a target player to get cards from"

    it "raises an error when an invalid target player index is chosen"

    it "asks the user for a rank of card to fish for"

    it "raises an error when a player specifies an invalid rank of card"
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
    it "returns true if the player has failed a catch"

    it "returns false if the player has successfully made a catch"
  end

  describe "#reset_turn" do
    it "causes #turn_over? to return false" do
      player.send :turn_over=, true
      player.reset_turn
      expect(player.turn_over?).to be(false)
    end
  end
end