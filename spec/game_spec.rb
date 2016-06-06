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

    half_played_board = ["X", "O", "X",
                         "-", "O", "-",
                         "-", "-", "-"]

    it "can switch players" do
        board = Board.new(empty_board)
        game = Game.new(board, player_x, player_o)
        (expect(game.switch_players("X")).to eq "O")
    end

    it "can create a board" do
        board = Board.new(empty_board)
        game = Game.new(board, player_x, player_o)
        expect(game.board.display).to eq("---\n---\n---\n")
    end

    it "can find empty position" do
        board = Board.new(half_played_board)
        game = Game.new(board, player_x, player_o)
        expect(game.empty_position?(0)).to eq false 
    end
end

