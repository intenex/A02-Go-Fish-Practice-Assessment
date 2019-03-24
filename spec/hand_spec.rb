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
      cards = [
        Card.new(:hearts, :four),
        Card.new(:diamonds, :deuce),
        Card.new(:clubs, :ace),
        Card.new(:hearts, :jack),
        Card.new(:spades, :king)
      ]
      hand = Hand.new(cards.dup)

      it "stores the cards passed to it" do
        expect(hand.cards).to match_array(cards)
      end

      it "sorts the cards" do
        expect(hand.cards).to eq(cards.sort_by { |card| Card.values.index(card.value) })
      end
    end

    describe "#has_rank?" do
      cards = [
        Card.new(:hearts, :four),
        Card.new(:diamonds, :deuce)
      ]
      hand = Hand.new(cards)

      it "returns true if any card in the hand matches the rank passed" do
        expect(hand.has_rank?(:four)).to be(true)
        expect(hand.has_rank?(:deuce)).to be(true)
      end

      it "returns false if no card in the hand matches the rank passed" do
        expect(hand.has_rank?(:five)).to be(false)
        expect(hand.has_rank?(:ace)).to be(false)
      end
    end

    describe "#add_cards" do
      cards = [
        Card.new(:hearts, :four),
        Card.new(:diamonds, :deuce)
      ]
      hand = Hand.new(cards.dup)
      new_cards = [
        Card.new(:diamonds, :five),
        Card.new(:spades, :ace)
      ]
      hand.add_cards(new_cards)
      it "adds the passed cards to the current hand of cards" do
        expect(hand.cards).to match_array(cards + new_cards)
      end

      it "sorts all the cards after adding the new cards" do
        expect(hand.cards).to eq(cards.concat(new_cards).sort_by { |card| Card.values.index(card.value) })
      end
    end

    describe "#remove_cards" do
      cards = [
        Card.new(:hearts, :four),
        Card.new(:diamonds, :four),
        Card.new(:clubs, :ace),
        Card.new(:hearts, :ace),
        Card.new(:spades, :king)
      ]
      hand = Hand.new(cards.dup)
      it "removes all the cards of the passed value from the hand" do
        hand.remove_cards(:four)
        new_cards = cards.reject { |card| card.value == :four }
        expect(hand.cards).to match_array(new_cards)
      end

      it "returns all the cards of the passed value that were removed" do
        removed_cards = cards.select { |card| card.value == :ace }
        expect(hand.remove_cards(:ace)).to match_array(removed_cards)
      end

      it "returns nil if no cards in the hand match the passed value" do
        expect(hand.remove_cards(:jack)).to be(nil)
      end
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