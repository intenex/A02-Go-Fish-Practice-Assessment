class Hand
  # This is a *factory method* that creates and returns a `Hand`
  # object.
  def self.deal_from(deck, num)
  end

  attr_accessor :cards

  def initialize(cards)
  end

  def has_rank?(val)
  end

  def add_cards(new_cards)
  end

  def remove_cards(val)
  end

  def book?
  end

  def remove_book
  end

  def empty?
  end

  def to_s
  end

  private
  def sort_cards
  end

  def count_values
  end
end