require_relative 'player'
require_relative 'deck'

class Game
    def initialize(*names)
        @deck = Deck.new
        @deck.shuffle
        @players = [Player.new(names[0]), Player.new(names[1])]
        @players.each { |player| player.hand = Hand.deal_from(@deck) }
        @current_player = 0
    end

    def play
        play_turn until game_over?
        end_game
    end

    private
    attr_reader :deck, :players
    attr_accessor :current_player

    def play_turn
        system('clear')
        player = players[current_player]
        opponent = players[(current_player + 1) % 2]
        player.go_fish(deck) if player.hand.empty?
        player.request_cards(opponent) until player.turn_over?
        player.reset_turn
        player.go_fish(deck)
        switch_players
    end

    def switch_players
        self.current_player = (current_player + 1) % 2
    end

    def game_over?
        deck.empty? && players.any? { |player| player.hand.empty? }
    end

    def winner
        players.max_by { |player| player.books }
    end

    def end_game
        puts "The game is over and the winner is #{winner.name} with #{winner.books} books!"
    end
end

def test
  g = Game.new("Alice", "Bob")
  g.play
end

if __FILE__ == $PROGRAM_NAME
  test
end