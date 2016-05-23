require 'board'

class Game

    attr_accessor :board

    def initialize(board, player_x, player_o)
        @board = board
        @player_x = player_x
        @player_o = player_o
    end

    def create_board(size)
        @board = Board.new(Array.new(size*size, "-"))
    end

    def play_next_move(mark, move)
      @board.mark(mark, move)
    end

    def calculate_player
      @board.positions("-").count % 2 == 0 ? @player_o : @player_x
    end

    def mark_board
      player = calculate_player
      @board.mark(player.mark, player.move(@board))
    end

    def game_over?
      @board.full? || @board.any_win?
    end

    def switch_players(mark)
      mark == "X" ? "O" : "X"
    end
end
