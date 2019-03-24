require 'player'

describe Player do
  subject(:player) do
    Player.new("Nick the Greek")
  end

  describe "#initialize" do
    it "assigns the name" do
      expect(player.name).to eq("Nick the Greek")
    end

    it "sets the number of @books to 0"
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
    it "takes one card from the deck and adds it to the player's hand"

    it "checks to see if a book is completed and increments @books if so"

    it "removes the book of cards if a book is completed"

    it "does nothing when the deck is empty"
  end

  describe "#get_cards" do
    it "removes all cards of the specified value from the player's hand"

    it "returns all cards removed"

    it "returns nil if no cards of the specified value were present in the player's hand"
  end

  describe "#turn_over?" do
    it "returns true if the player has failed a catch"

    it "returns false if the player has successfully made a catch"
  end

  describe "#reset_turn" do
    it "causes #turn_over? to return false"
  end
end