class Hand
  # This is a *factory method* that creates and returns a `Hand`
  # object.
  def self.deal_from(deck)
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def add_cards(cards)
  end

  def retrieve_cards(value)

  end

  def remove_book
  end

  def book?
  end

  def empty?
  end

  def to_s
    @cards.join(",") # unclear this works, test
  end
end
