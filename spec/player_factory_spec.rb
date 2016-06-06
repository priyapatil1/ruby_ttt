require "player_factory"
require "console"

describe PlayerFactory do
  let (:input) {StringIO.new("")}
  let (:output) {StringIO.new("")}
  let (:console) {Console.new(input, output)}

  it "creates a human as X if choice 1" do
    player_factory = PlayerFactory.new(console)
    expect(player_factory.make_x(1)).to be_a_kind_of(HumanPlayer)
  end

  it "creates a human as O if choice 1" do
    player_factory = PlayerFactory.new(console)
    expect(player_factory.make_o(1)).to be_a_kind_of(HumanPlayer)
  end

  it "creates a human as X if choice 2" do
    player_factory = PlayerFactory.new(console)
    expect(player_factory.make_x(2)).to be_a_kind_of(HumanPlayer)
  end

  it "creates a computer as O if choice 2" do
    player_factory = PlayerFactory.new(console)
    expect(player_factory.make_o(2)).to be_a_kind_of(ComputerPlayer)
  end

  it "creates a computer as X if choice 3" do
    player_factory = PlayerFactory.new(console)
    expect(player_factory.make_x(3)).to be_a_kind_of(ComputerPlayer)
  end

  it "creates a human as O if choice 3" do
    player_factory = PlayerFactory.new(console)
    expect(player_factory.make_o(3)).to be_a_kind_of(HumanPlayer)
  end

  it "creates a computer as O if choice 4" do
    player_factory = PlayerFactory.new(console)
    expect(player_factory.make_x(4)).to be_a_kind_of(ComputerPlayer)
  end

  it "creates a computer as X if choice 4" do
    player_factory = PlayerFactory.new(console)
    expect(player_factory.make_o(4)).to be_a_kind_of(ComputerPlayer)
  end
end
