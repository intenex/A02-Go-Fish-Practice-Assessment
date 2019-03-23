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
    puts "Your turn, #{@name}. You have #{@books} books."
    puts "Your current hand: #{hand.to_s}"
    puts "Choose a rank of card to request, e.g. '2', 'J', 'K'"
    handle_input(gets.chomp.upcase)
  rescue ArgumentError => e
    puts e
    retry
  end

  def handle_input(input)
    valid_ranks = Card::VALUE_STRINGS.invert
    guessed_rank = valid_ranks[input]
    check_for_errors(guessed_rank)
    guessed_ranks << guessed_rank
    received_cards = opponent.get_cards(guessed_rank)
    handle_cards(received_cards)
  end

  def check_for_errors(guessed_rank)
    raise ArgumentError.new("Invalid rank. Try again.") unless guessed_rank
    raise ArgumentError.new("You don't have that rank. Try again.") unless self.hand.has_rank?(guessed_rank)
    raise ArgumentError.new("You already guessed that. Try again.") if self.guessed_ranks.include?(guessed_rank)
  end

  def handle_cards(cards)
    if cards
      hand.add_cards(cards)
      check_for_book
      hand.sort_cards
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
      puts "#{@name} fished a #{fished_card[0].to_s}!"
      hand.add_cards(fished_card)
      check_for_book
      hand.sort_cards
    else
      puts "The deck is empty and there are no cards to fish."
    end
  end

  def all_cards_guessed?
    hand.cards.all? { |card| guessed_ranks.include?(card.value) }
  end

  def get_cards(value)
    hand.remove_cards(value)
  end

  def check_for_book
    if hand.book?
      hand.remove_book
      books += 1
    end
  end

  def turn_over?
    turn_over
  end

  def reset_turn
    self.turn_over = false
  end
end
