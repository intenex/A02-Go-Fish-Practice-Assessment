require_relative '00_card'

# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
    all_cards = []

    Card.suits.each do |suit|
      Card.values.each do |value|
        all_cards << Card.new(suit, value)
      end
    end

    all_cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def empty?
    @cards.empty?
  end

  def count
    @cards.count
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    raise "not enough cards" if count < n
    @cards.shift(n)
  end

  def shuffle
    @cards.shuffle!
  end
end