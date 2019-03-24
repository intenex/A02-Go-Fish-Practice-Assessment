require 'card'
require 'hand'

describe Hand do
  describe "::deal_from" do
    it "deals a hand of seven cards with three or fewer players" do
      deck_cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three)
      ]

      deck = double("deck")
      expect(deck).to receive(:take).with(2).and_return(deck_cards)

      hand = Hand.deal_from(deck)

      expect(hand.cards).to match_array(deck_cards)
    end

    it "deals a hand of five cards with four or more players"
  end

end
