#! usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require "game"
require "console"
require "console_game"
require "human_player"

begin
    empty_board = ["-", "-", "-",
                   "-", "-", "-",
                   "-", "-", "-"]

    console = Console.new(STDIN, Kernel)
    board = Board.new(empty_board)
    player_x = HumanPlayer.new(console, "X")
    player_o = HumanPlayer.new(console, "O")
    game = Game.new(board, player_x, player_o)
    ConsoleGame.new(game, console).start
end


