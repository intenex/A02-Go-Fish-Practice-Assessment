class Hand
  # This is a *factory method* that creates and returns a `Hand`
  # object.
  def self.deal_from(deck)
    Hand.new(deck.take(7))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def has_rank?(value)

  end

  def add_cards(cards)
    self.cards.concat(cards)
  end

  def remove_cards(val)
    removed_cards = @cards.select { |card| card.value == val }
    self.cards.delete_if { |card| card.value == val }
    removed_cards.empty? ? nil : removed_cards
  end

  def remove_book
    value_counter = self.count_values

  end

  def book?
    value_counter = self.count_values
    value_counter.any? { |value| value == 4 }
  end

  def count_values
    value_counter = Hash.new(0)
    self.cards.each do |card|
      value_counter[card.value] += 1
    end
    value_counter
  end

  def empty?
    self.cards.empty?
  end

  def to_s
    @cards.join(",") # unclear this works, test
  end
end
