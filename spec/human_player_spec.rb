require "human_player"
require "console"

describe HumanPlayer do
    empty_three = ["-", "-", "-",
                   "-", "-", "-",
                   "-", "-", "-"]

    let(:input) {StringIO.new("3\n")}
    let(:output) {StringIO.new("")}
    let(:console) {Console.new(input, output)}
    let(:player_x) {HumanPlayer.new(console, "X")}
    let(:board) {Board.new(empty_three)}

    it "has X as a mark" do
        expect(player_x.mark).to eq "X"
    end

    it "can get an input from the user" do 
      expect(player_x.move(board)).to eq(3)
    end
end


