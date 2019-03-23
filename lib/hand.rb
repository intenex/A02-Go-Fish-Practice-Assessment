class Hand
  # This is a *factory method* that creates and returns a `Hand`
  # object.
  def self.deal_from(deck)
    Hand.new(deck.take(7))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
    sort_cards
  end

  def sort_cards
    @cards.sort_by! { |card| Card.values.index(card.value) }
  end

  def has_rank?(val)
    @cards.any? { |card| card.value == val }
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
    book_value = value_counter.select { |key, value| value == 4 }
    book_value.keys.each do |val|
      self.cards.delete_if { |card| card.value == val }
    end
  end

  def book?
    value_counter = self.count_values
    value_counter.any? { |key, value| value == 4 }
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
    @cards.join(", ")
  end
end