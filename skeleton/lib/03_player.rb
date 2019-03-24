require_relative '02_hand'

class Player
  attr_reader :name
  attr_accessor :hand, :books, :turn_over

  def initialize(name)
  end

  def request_cards(opponents)
  end

  def go_fish(deck)
  end

  def turn_over?
  end

  def reset_turn
  end

  def get_cards(value)
  end

  def opponent_prompt(opponents)
  end

  def rank_prompt(opponent)
  end
  
  def handle_opponent(input, opponents)
  end

  def handle_rank(input, opponent)
  end

  def check_for_rank_errors(guessed_rank)
  end

  def handle_cards(cards)
  end

  def check_for_book
  end
end