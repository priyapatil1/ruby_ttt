require 'gui_computer_player'
require 'spec_helper'

describe GuiComputerPlayer do
  it 'has a time delay' do
    gui_computer_player = GuiComputerPlayer.new("X", ComputerPlayer.new("X"))
    expect(gui_computer_player.delay?).to eq true
  end
end
