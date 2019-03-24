require_relative 'player'
require_relative 'deck'

class Game
    def initialize(*names)
        @deck = Deck.new
        @deck.shuffle
        @players = []
        names.each { |name| @players << Player.new(name) }
        starting_cards = @players.size < 4 ? 7 : 5
        @players.each { |player| player.hand = Hand.deal_from(@deck, starting_cards) }
        @finished_players = []
        @current_player = 0
    end

    def play
        play_turn until game_over?
        end_game
    end

    private
    attr_reader :deck, :players, :finished_players
    attr_accessor :current_player

    def play_turn
        system('clear')
        player = players[current_player]
        opponents = players - [player]
        player.go_fish(deck) if player.hand.empty?
        player.request_cards(opponents) until player.turn_over?
        player.reset_turn
        player.go_fish(deck)
        check_players_out if deck.empty?
        switch_players
    end

    def check_players_out
        players.each do |player|
            if player.hand.empty?
                puts "#{player.name} has run out of cards and finishes with #{player.books} books."
                finished_players << players.delete(player)
                sleep(1)
            end
        end
    end

    def switch_players
        self.current_player = (current_player + 1) % players.size
    end

    def game_over?
        deck.empty? && players.all? { |player| player.hand.empty? }
    end

    def winner
        all_players = players + finished_players
        all_players.max_by { |player| player.books }
    end

    def end_game
        puts "The game is over and the winner is #{winner.name} with #{winner.books} books!"
    end
end

def test
  g = Game.new("Alice", "Bob", "Charlie", "Daisy")
  g.play
end

if __FILE__ == $PROGRAM_NAME
  test
end