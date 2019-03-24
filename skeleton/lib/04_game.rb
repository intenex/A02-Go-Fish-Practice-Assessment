require_relative '01_deck'
require_relative '03_player'

class Game
    attr_reader :deck, :players, :finished_players
    attr_accessor :current_player

    def initialize(*names)
    end

    def play
    end

    def play_turn
    end

    def check_players_out
    end

    def switch_players
    end

    def game_over?
    end

    def winner
    end

    def end_game
    end
end