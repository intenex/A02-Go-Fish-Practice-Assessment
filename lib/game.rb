require_relative 'player'
require_relative 'deck'

class Game

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
        player = @players[@current_player]
        opponent = @players[@current_player + 1 % 2]
        player.request_card(opponent) until player.turn_over?
        player.go_fish
        @current_player = (@current_player + 1) % 2
    end

    def game_over?
    end

    def end_game
    end

end