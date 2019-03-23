require_relative 'hand'

class Player
  attr_reader :name
  attr_accessor :hand, :turn_over, :books, :guessed_ranks

  def initialize(name)
    @name = name
    @turn_over = false
    @books = 0
    @guessed_ranks = []
  end

  def request_cards(opponent)
    puts "Choose a rank of card to request, e.g. '2', 'J', 'K'"
    rank = gets.input.upcase
    valid_ranks = Card::VALUE_STRINGS.invert
    guessed_rank = valid_ranks[rank]
    raise ArgumentError.new("Invalid rank. Try again.") unless guessed_rank
    raise ArgumentError.new("You don't have that rank. Try again.") unless self.hand.has_rank?(guessed_rank)
    self.guessed_ranks << guessed_rank
    received_cards = opponent.get_cards(guessed_rank)
    self.handle_cards(received_cards)
  rescue => e
    puts e
    retry
  end

  def handle_cards(cards)
    if cards
      self.hand.add_cards(cards)
      self.check_for_book
      self.turn_over = true if self.all_cards_guessed?
    else
      self.turn_over = true
    end
  end

  def reset_guesses
    self.guessed_ranks = []
  end

  def go_fish(deck)
    if !deck.empty?
      fished_card = deck.take(1)
      puts "You fished a #{fished_card.to_s}!"
      self.hand.add_cards(fished_card)
    else
      puts "The deck is empty and there are no cards to fish."
    end
  end

  def all_cards_guessed?
    self.hand.cards.all? { |card| self.guessed_ranks.include?(card.value) }
  end

  def get_cards(value)
    self.hand.retrieve_cards(value)
  end

  def check_for_book
    if self.hand.book?
      self.hand.remove_book
      self.books += 1
    end
  end

  def turn_over?
    self.turn_over
  end

  def reset_turn
    self.turn_over = true
  end
end
