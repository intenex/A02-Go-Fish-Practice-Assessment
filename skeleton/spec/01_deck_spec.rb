require '00_card'
require '01_deck'

describe Deck do
  describe "::all_cards" do
    subject(:all_cards) { Deck.all_cards }

    it "starts with a count of 52" do
      expect(all_cards.count).to eq(52)
    end

    it "returns all cards without duplicates" do
      all_card_vals = Card.suits.product(Card.values).sort

      deduped_cards = all_cards
        .map { |card| [card.suit, card.value] }
        .sort
        
      expect(deduped_cards).to eq(all_card_vals)
    end
  end

  let(:cards) do
    cards = [
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack)
    ]
  end

  describe "#initialize" do
    it "by default fills itself with 52 cards" do
      deck = Deck.new
      expect(deck.count).to eq(52)
    end

    it "can be initialized with an array of cards" do
      deck = Deck.new(cards)
      expect(deck.count).to eq(3)
    end
  end

  let(:deck) do
    Deck.new(cards.dup)
  end

  it "does not expose its cards directly" do
    expect(deck).not_to respond_to(:cards)
  end

  describe "#take" do
    # **use the front of the cards array as the top**
    it "takes cards off the top of the deck" do
      expect(deck.take(1)).to eq(cards[0..0])
      expect(deck.take(2)).to eq(cards[1..2])
    end

    it "removes cards from deck on take" do
      deck.take(2)
      expect(deck.count).to eq(1)
    end

    it "doesn't allow you to take more cards than are in the deck" do
      expect do
        deck.take(4)
      end.to raise_error("not enough cards")
    end
  end

  describe "#empty?" do
    it "returns true if the deck is empty" do
      deck = Deck.new([])
      expect(deck.empty?).to be(true)
    end

    it "returns false if the deck is not empty" do
      deck = Deck.new(cards)
      expect(deck.empty?).to be(false)
    end
  end

  describe "count" do
    it "returns the number of cards in the deck" do
      deck = Deck.new(cards)
      expect(deck.count).to be(3)
    end
  end

  describe "#shuffle" do
    it "shuffles all the cards in the deck" do
      original_cards = Deck.all_cards
      deck = Deck.new(original_cards.dup)
      deck.shuffle
      expect(deck.instance_variable_get(:@cards)).to match_array(original_cards)
      expect(deck.instance_variable_get(:@cards)).not_to eq(original_cards)
    end
  end
end