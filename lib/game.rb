require 'board'

class Game

    attr_accessor :console
    attr_accessor :board

    def initialize(console, board)
        @console = console
        @board = board
    end

    def user_mark_board(mark)
        input = console.get_input(@board.cells.count)
        @board.mark(mark, input)
    end

    def switch_players(mark)
        mark == "X" ? "O" : "X"
    end

    def start
        console.greeting_message
        input = console.get_valid_input(100)
        @board = @board.create_board(input)
        console.show_output(@board.display)
        game_loop("X", "O")
    end

    def game_loop(player_one, player_two)
        new_board = @board.mark(player_one, console.get_valid_input(@board.cells.size))
        console.clear_screen
        @console.show_output(new_board.display)
        if new_board.full? || new_board.any_win?
            console.end_of_game_message
        else
            game_loop(player_two, player_one)
        end
    end
end
