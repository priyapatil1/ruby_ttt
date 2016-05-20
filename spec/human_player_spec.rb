require "human_player"

describe HumanPlayer do
    empty_three = ["-", "-", "-",
                   "-", "-", "-",
                   "-", "-", "-"]

    let(:input) {StringIO.new("3\n")}
    let(:output) {StringIO.new("")}
    let(:console) {Console.new(input, output)}
    let(:board) {Board.new(empty_three)}
    let(:human_player) {HumanPlayer.new(console, "X")}

    it "has X as a mark" do
        expect(human_player.mark).to eq "X"
    end

    it "can get an input from the user" do 
      expect(human_player.move(board)).to eq(3)
    end
end


