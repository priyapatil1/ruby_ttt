require 'game'
require 'board'

describe Game do
    let(:input) {StringIO.new("")}
    let(:output) {StringIO.new("")}
    let(:console) {Console.new(input, output)}
    let(:player_x) {HumanPlayer.new(console,"X")}
    let(:player_o) {HumanPlayer.new(console,"O")}

    empty_board = ["-", "-", "-",
                   "-", "-", "-",
                   "-", "-", "-"]

    it "can switch players" do
        board = Board.new(console)
        game = Game.new(empty_board, player_x, player_o)
        (expect(game.switch_players("X")).to eq "O")
    end

    it "can create a board" do
        board = Board.new(console)
        game = Game.new(empty_board, player_x, player_o)
        expect(game.create_board(3).display).to eq("---\n---\n---\n")
    end

end

