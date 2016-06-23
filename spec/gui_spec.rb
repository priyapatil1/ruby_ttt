require 'spec_helper'
require 'qt'
require 'qt_helpers'
require 'gui'

describe Gui do
    @game = Game.new(@board, @player_x, @player_o)

  before(:all) do
    app = Qt::Application.new(ARGV)
  end

  let(:board) {Board.new(Array.new(9, "-"))}
  let(:player_x) {GuiPlayer.new("X")}
  let(:player_o) {GuiPlayer.new("O")}
  let(:game) {Game.new(board, player_x, player_o)}
  let(:gui) {Gui.new(board, game)}

  describe 'gui elements' do
    it 'is a window' do
      expect(gui).to be_kind_of(Qt::Widget)
      expect(gui.parent).to be_nil
    end

    it 'has a title' do
      expect(gui.windowTitle).to eq("Tic Tac Toe: Human v Human")
    end

    it 'has a status bar' do
      expect(gui.find_child(Qt::StatusBar, 'game status').currentMessage).to eq("X's turn")
    end

    it 'creates a grid gui based on the size of the board' do
      expect(gui.size).to eq 2
    end

    it 'has a menu bar' do
      expect(gui.find_child(Qt::MenuBar, 'menu bar')).to be_kind_of(Qt::MenuBar)
    end

    it 'has a default size' do
      expect(gui.height).to eq(1605)
      expect(gui.width).to eq(1605)
    end

    it "has a grid layout" do
      expect(gui.find_child(Qt::GridLayout, 'grid')).to be_kind_of(Qt::GridLayout)
    end

    it 'has a size of 3 x 3' do
      expect(gui.find_child(Qt::GridLayout, 'grid').columnCount).to eq 3 
    end

    it 'has a menu bar' do
      expect(gui.find_child(Qt::MenuBar, 'menu bar').actions[0].text).to eq("&File")
    end
  end

  describe 'effects of user choices' do
    xit 'changes status bar after move made' do
      gui.create_buttons(board)
      click_buttons(["1"])
      expect(gui.find_child(Qt::StatusBar, 'game status').currentMessage).to eq("O's turn")
    end

    xit 'changes status bar when winner found' do
      gui.create_buttons(board)
      click_buttons(["0", "5", "1", "6", "2", "7"])
      expect(gui.find_child(Qt::StatusBar, 'game status').currentMessage).to eq("X is the winner!")
    end

    xit 'can changes gui when button is clicked' do
      gui.create_buttons(board)
      click_buttons(["1"])
      expect(gui.buttons[1].text).to eq "X" 
    end
  end

  xit 'shows a message box when the game has been won' do
    gui.create_buttons(board)
    click_buttons(["0", "5", "1", "6", "2", "7"])
    message_box = find_widget_by_text("Game Over, X has won! Play Again?")
    expect(message_box).to be_kind_of(Qt::MessageBox)
  end

  xit 'does not allow the user to choose an occupied position' do 
    gui.create_buttons(board)
    click_buttons(["0", "0", "1", "6", "2", "7"])
    message_box = find_widget_by_text("Game Over")
    expect(message_box).to be_kind_of(Qt::MessageBox)
  end

  xit 'allows a player to play a new game' do 
    gui.create_buttons(board)
    click_buttons(["0", "0", "1", "6", "2", "7"])
    message_box = find_widget_by_text("Game Over! X has won! Play again?")
    expect(message_box).to be_kind_of(Qt::MessageBox)
  end

  private 

  def click_buttons(buttons)
    buttons.each do |button|
      find_widget(button).click
    end
  end

  def find_widget(name) 
    gui.children.find {|d| d.object_name == name}
  end

  def find_widget_by_text(name) 
    gui.children.find {|d| d.text == name}
  end
end
