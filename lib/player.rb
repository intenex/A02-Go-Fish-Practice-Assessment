require_relative 'hand'

class Player
  attr_reader :name
  attr_accessor :hand, :turn_over

  def initialize(name)
    @turn_over = false
  end

  def return_cards(deck)
  end

  def request_card(opponent)
    puts "Choose a rank of card to request"
    rank = gets.input.upcase
  end

  def check_for_set
  end

  def turn_over?
    self.turn_over
  end

end
