#! usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require "game"
require "console"

begin
    empty_board = ["-", "-", "-",
                   "-", "-", "-",
                   "-", "-", "-"]

    console = Console.new(STDIN, Kernel)
    board = Board.new(empty_board)
    Game.new(console, board).start()
end


