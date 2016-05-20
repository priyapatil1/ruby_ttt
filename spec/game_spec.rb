require 'game'
require 'board'

describe Game do
    let(:input) {StringIO.new("")}
    let(:output) {StringIO.new("")}
    let(:console) {Console.new(input, output)}

    empty_board = ["-", "-", "-",
                   "-", "-", "-",
                   "-", "-", "-"]

    it "can switch players" do
        board = Board.new(console)
        game = Game.new(console, empty_board)
        (expect(game.switch_players("X")).to eq "O")
    end

    it "plays a game through to the end" do
        input = StringIO.new("3\n0\n1\n2\n3\n4\n5\n6\n")
        console = Console.new(input, output)
        board = Board.new(empty_board)
        game = Game.new(console, board)
        game.start
        (expect(output.string.chomp)).to include "Hi please choose a board size"
        (expect(output.string.chomp)).to include "Game Over"
    end
end

