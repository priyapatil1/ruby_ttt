require "menu"

describe Menu do
  let (:input) {StringIO.new("1\n3\n0\n1\n2\n3\n4\n5\n6")}
  let (:output) {StringIO.new("1\n")}
  let (:console) {Console.new(input, output)}
  let (:game_creator) {GameSetup.new(console)}

  it "displays options for game types" do
    menu = Menu.new(game_creator)
    expect(menu.display_choices).to eq"1) Human v Human\n" + 
                                      "2) Human v Computer\n"+ 
                                      "3) Computer v Human\n" + 
                                      "4) Computer v Computer\n"
  end

  it "creates a Human v Human game given choice 1" do
    menu = Menu.new(console)
    menu.start
    expect(output.string.chomp).to include("Game Over")
  end
end
