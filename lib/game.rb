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

    def calculate_player
      @board.positions("-").count % 2 == 0 ? @player_o : @player_x
    end

    def mark_board
      current_player = calculate_player
      current_player_move = current_player.move(@board)
      @board = board.mark(current_player.mark, current_player_move)
    end

    def game_over?
      @board.full? || @board.any_win?
    end

    def switch_players(mark)
      mark == "X" ? "O" : "X"
    end
end
