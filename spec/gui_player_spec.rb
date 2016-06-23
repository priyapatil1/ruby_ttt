require 'gui_player'
require 'gui'

describe GuiPlayer do
  before(:all) do
    app = Qt::Application.new(ARGV)
  end

  let(:board) {Board.new(Array.new(9, "-"))}
  let(:player) {GuiPlayer.new("X")}

  it 'has a mark X' do
    expect(player.mark).to eq "X" 
  end

  it 'sets has mark to true when a move is given' do 
    player.next_move = 3
    expect(player.has_move?).to eq true
  end

  it 'sets has move to false when move made' do
    player.next_move = 3
    player.move(board)
    expect(player.has_move?).to eq false 
  end

  def click_buttons(buttons)
    buttons.each do |button|
      find_widget(button).click
    end
  end

  def find_widget(name) 
    gui.children.find {|d| d.object_name == name}
  end
end
