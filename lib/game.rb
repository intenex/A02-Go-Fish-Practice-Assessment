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
        deck.shuffle
        play_turn until game_over?
        end_game
    end

    def play_turn
        player = self.players[self.current_player]
        opponent = self.players[self.current_player + 1 % 2]
        player.request_cards(opponent) until player.turn_over?
        player.reset_turn
        player.go_fish
        self.current_player = (self.current_player + 1) % 2
    end

    def game_over?
        
    end

    def end_game
    end

end