require_relative 'hand'

class Player
  attr_reader :name
  attr_accessor :hand, :books, :turn_over

  def initialize(name)
    @name = name
    @turn_over = false
    @books = 0
  end

  def request_cards(opponents)
    opponent = opponent_prompt(opponents)
    rank_prompt(opponent)
  end

  def go_fish(deck)
    unless deck.empty?
      fished_card = deck.take(1)
      puts "#{@name} fished a #{fished_card[0].to_s}!"
      hand.add_cards(fished_card)
      check_for_book
      sleep(1)
    else
      puts "The deck is empty and there are no cards to fish."
    end
  end

  def turn_over?
    turn_over
  end

  def reset_turn
    self.turn_over = false
  end

  def get_cards(value)
    hand.remove_cards(value)
  end

  def opponent_prompt(opponents)
    puts "Your turn, #{name}. You have #{books} books."
    puts "Your current hand: #{hand.to_s}"
    puts "Choose a player to pick a card from by their number:"
    player_string = "Players: "
    opponents.each_with_index do |player, idx|
      player_string += (idx.to_s + ': ' + player.name + ', ')
    end
    puts player_string[0...-2]
    handle_opponent(gets.chomp.to_i, opponents)
  end

  def rank_prompt(opponent)
    system('clear')
    puts "Your current hand: #{hand.to_s}"
    puts "Choose a rank of card to request from #{opponent.name}, e.g. '2', 'J', 'K'"
    handle_rank(gets.chomp.upcase, opponent)
  end
  
  def handle_opponent(input, opponents)
    opponent = opponents[input]
    raise ArgumentError.new("That was not a valid choice. Try again.") unless opponent
    opponent
  end

  def handle_rank(input, opponent)
    valid_ranks = Card::VALUE_STRINGS.invert
    guessed_rank = valid_ranks[input]
    check_for_rank_errors(guessed_rank)
    received_cards = opponent.get_cards(guessed_rank)
    handle_cards(received_cards)
  end

  def check_for_rank_errors(guessed_rank)
    raise ArgumentError.new("Invalid rank. Try again.") unless guessed_rank
    raise ArgumentError.new("You don't have that rank. Try again.") unless hand.has_rank?(guessed_rank)
  end

  def handle_cards(cards)
    if cards
      puts "#{name} caught #{cards.size} card[s]: #{cards.join(' ')}"
      hand.add_cards(cards)
      check_for_book
      self.turn_over = true if hand.empty?
      sleep(1)
    else
      puts "You didn't catch any cards. Go fish!"
      self.turn_over = true
      sleep(1)
    end
  end

  def check_for_book
    if hand.book?
      hand.remove_book
      self.books += 1
    end
  end
end