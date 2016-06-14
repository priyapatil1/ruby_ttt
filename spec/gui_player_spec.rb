require 'gui_player'
require 'gui'

describe GuiPlayer do
  before(:all) do
    app = Qt::Application.new(ARGV)
  end

  let(:board) {Board.new(Array.new(9, "-"))}
  let(:display) {Gui.new(board)}

  it 'has a mark X' do
    gui_player = GuiPlayer.new(Gui.new(board), "X")
    expect(gui_player.mark).to eq "X" 
  end
end
