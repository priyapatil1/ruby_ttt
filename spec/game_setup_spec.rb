require "game_setup"

describe GameSetup do
    let(:input) {StringIO.new("0\n1\n2\n3\n4\n5\n6\n")}
    let(:output) {StringIO.new("")}
    let(:console) {Console.new(input, output)}

  it "creates a new human v human game" do
    game_setup = GameSetup.new(console)
    created_game = game_setup.create(1, 3)
    expect(created_game.player_x).to be_a_kind_of(HumanPlayer)
  end
end
