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

    def next_player
      @board.played_cells
        .count % 2 == 0 ? @player_x : @player_o
    end

    def previous_player
      @board.played_cells
        .count % 2 == 0 ? @player_o : @player_x
    end

    def mark_board
      return @board if game_over?
      current_player_move = next_player.move(board)
      @board = board.mark(next_player.mark, current_player_move)
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

    def mark_at(index)
      board.cells[index]
    end
end
