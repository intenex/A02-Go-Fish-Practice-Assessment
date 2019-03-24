require 'card'
require 'hand'

describe Hand do
  describe "::deal_from" do
    it "deals a hand of seven cards with three or fewer players" do
      deck_cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:hearts, :four),
        Card.new(:diamonds, :ace),
        Card.new(:clubs, :ace),
        Card.new(:hearts, :jack),
        Card.new(:spades, :king)
      ]

      deck = double("deck")
      expect(deck).to receive(:take).with(7).and_return(deck_cards)

      hand = Hand.deal_from(deck, 7)

      expect(hand.cards).to match_array(deck_cards)
    end

    it "deals a hand of five cards with four or more players" do
        deck_cards = [
        Card.new(:hearts, :four),
        Card.new(:diamonds, :ace),
        Card.new(:clubs, :ace),
        Card.new(:hearts, :jack),
        Card.new(:spades, :king)
      ]

      deck = double("deck")
      expect(deck).to receive(:take).with(5).and_return(deck_cards)

      hand = Hand.deal_from(deck, 5)

      expect(hand.cards).to match_array(deck_cards)
    end

    describe "#initialize" do
      it "stores the cards passed to it"

      it "sorts the cards"
    end

    describe "#has_rank?" do
      it "returns true if any card in the hand matches the rank passed"

      it "returns false if no card in the hand matches the rank passed"
    end

    describe "#add_cards" do
      it "adds the passed cards to the current hand of cards"

      it "sorts all the cards after adding the new cards"
    end

    describe "#remove_cards" do
      it "removes all the cards of the passed value from the hand"

      it "returns all the cards of the passed value that were removed"

      it "returns nil if no cards in the hand match the passed value"
    end

    describe "#book" do
      it "returns true if the hand contains a full book of cards"

      it "returns false if the hand does not contain a full book of cards"
    end

    describe "#remove_book" do
      it "removes a book of cards from the hand if present"

      it "does nothing if no book of cards are present"
    end

    describe "#empty?" do
      it "returns true if the hand is empty"

      it "returns false if the hand is not empty"
    end

    describe "#to_s" do
      it "returns a string representation of all the cards in the hand separated by a comma"
    end
  end
end