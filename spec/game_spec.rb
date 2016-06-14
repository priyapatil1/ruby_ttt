require 'game'
require 'board'

describe Game do
    let(:input) {StringIO.new("1\n")}
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

    it "can calculate the previous player" do 
        board = Board.new(empty_board)
        game = Game.new(board, player_x, player_o)
        game.mark_board
        expect(game.previous_player).to eq(game.player_x)
    end

    it "can calculate the next player" do 
        board = Board.new(empty_board)
        game = Game.new(board, player_x, player_o)
        game.mark_board
        expect(game.next_player).to eq(game.player_o)
    end

    it "can find empty position" do
        board = Board.new(half_played_board)
        game = Game.new(board, player_x, player_o)
        expect(game.empty_position?(0)).to eq false 
    end
end

