require_relative 'hand'

class Player
  attr_reader :name
  attr_accessor :hand, :turn_over, :books

  def initialize(name)
    @name = name
    @turn_over = false
    @books = 0
  end

  def request_cards(opponent)
    puts "Choose a rank of card to request, e.g. '2', 'J', 'K'"
    rank = gets.input.upcase
    valid_values = Card::VALUE_STRINGS.invert
    raise ArgumentError.new("Invalid value. Please try again.") unless valid_values[rank]
    received_cards = opponent.get_cards(valid_values[rank])
    if received_cards
      self.hand.add_cards(received_cards)
      self.check_for_book
    else
      self.turn_over = true
    end
  rescue => e
    puts e
    retry
  end

  def get_cards(value)

  end

  def check_for_book
  end

  def turn_over?
    self.turn_over
  end

  def reset_turn
    self.turn_over = true
  end
end
