require 'board'

class Game
    attr_accessor :board
    attr_accessor :player_x
    attr_accessor :player_o

    def initialize(board, player_x, player_o)
        @board = board
        @player_x = player_x
        @player_o = player_o
    end

    def calculate_player
      @board.positions("-")
        .count % 2 == 0 ? @player_o : @player_x
    end

    def mark_board
      current_player = calculate_player
      current_player_move = current_player.move(board)
      @board = board.mark(current_player.mark, current_player_move)
      @board.display
    end

    def empty_position?(input)
      @board.cells[input] == "-"
    end

    def game_over?
      @board.full? || @board.any_win?
    end

    def switch_players(mark)
      mark == "X" ? "O" : "X"
    end
end
