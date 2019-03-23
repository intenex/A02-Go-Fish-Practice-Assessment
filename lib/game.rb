require_relative 'player'
require_relative 'deck'

class Game
    attr_reader :deck, :players
    attr_accessor :current_player

    def initialize
        @deck = Deck.new
        @players = []
        @current_player = 0
    end

    def play
        deck.shuffle!
        play_turn until game_over?
        end_game
    end

    def play_turn
        player = self.players[self.current_player]
        opponent = self.players[self.current_player + 1 % 2]
        player.request_cards(opponent) until player.turn_over?
        player.reset_turn
        player.go_fish
        self.switch_players
    end

    def switch_players
        self.current_player = (self.current_player + 1) % 2
    end

    def game_over?
        self.deck.empty? && self.players.any? { |player| player.hand.empty? }
    end

    def winner
        self.players.max_by { |player| player.books }
    end

    def end_game
        puts "The game is over and the winner is #{winner.name}!"
    end
end