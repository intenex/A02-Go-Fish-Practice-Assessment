require 'card'
require 'hand'

describe Hand do
  describe "::deal_from" do
    it "deals a hand of seven cards" do
      deck_cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three)
      ]

      deck = double("deck")
      expect(deck).to receive(:take).with(2).and_return(deck_cards)

      hand = Hand.deal_from(deck)

      expect(hand.cards).to match_array(deck_cards)
    end
  end

  describe "#return_cards" do
    let(:deck) { double("deck") }
    let(:hand) do
      Hand.new([Card.new(:spades, :deuce), Card.new(:spades, :three)])
    end

    it "returns cards to deck" do
      expect(deck).to receive(:return) do |cards|
        expect(cards.count).to eq(2)
      end

      hand.return_cards(deck)
    end

    it "removes card from hand" do
      allow(deck).to receive(:return)

      hand.return_cards(deck)
      expect(hand.cards).to eq([])
    end
  end
end
