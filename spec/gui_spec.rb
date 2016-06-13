require 'spec_helper'
require 'qt'
require 'qt_helpers'
require 'gui'

describe Gui do

  before(:all) do
    app = Qt::Application.new(ARGV)
  end

  let(:board) {Board.new(Array.new(9, "-"))}
  let(:display) {Gui.new(board)}

  describe 'display elements' do
    it 'is a window' do
      expect(display).to be_kind_of(Qt::Widget)
      expect(display.parent).to be_nil
    end

    it 'has a title' do
      expect(display.windowTitle).to eq("Tic Tac Toe: Human v Human")
    end

    it 'has a status bar' do
      expect(display.find_child(Qt::StatusBar, 'game status').currentMessage).to eq("X's turn")
    end

    it 'creates a grid display based on the size of the board' do
      expect(display.size).to eq 2
    end

    it 'has a menu bar' do
      expect(display.find_child(Qt::MenuBar, 'menu bar')).to be_kind_of(Qt::MenuBar)
    end

    it 'has a default size' do
      expect(display.height).to eq(1605)
      expect(display.width).to eq(1605)
    end

    it "has a grid layout" do
      expect(display.find_child(Qt::GridLayout, 'grid')).to be_kind_of(Qt::GridLayout)
    end

    it 'has a size of 3 x 3' do
      expect(display.find_child(Qt::GridLayout, 'grid').columnCount).to eq 3 
    end

    it 'has a menu bar' do
      expect(display.find_child(Qt::MenuBar, 'menu bar').actions[0].text).to eq("&File")
    end
  end

  describe 'effects of user choices' do
    it 'changes status bar after move made' do
      display.create_buttons(board)
      click_buttons(["1"])
      expect(display.find_child(Qt::StatusBar, 'game status').currentMessage).to eq("O's turn")
    end

    xit 'changes status bar when winner found' do
      display.create_buttons
      click_buttons(["0", "5", "1", "6", "2", "7"])
      expect(display.find_child(Qt::StatusBar, 'game status').currentMessage).to eq("X is the winner!")
    end

    it 'can changes display when button is clicked' do
      display.create_buttons(board)
      click_buttons(["1"])
      first_cell = find_widget("1")
      expect(first_cell.text).to eq "X" 
    end
  end

  xit 'shows a message box when the game has been won' do
    display.create_buttons(board)
    click_buttons(["0", "5", "1", "6", "2", "7"])
    message_box = find_widget_by_text("Game Over, X has won! Play Again?")
    expect(message_box).to be_kind_of(Qt::MessageBox)
  end

  xit 'does not allow the user to choose an occupied position' do 
    display.create_buttons(board)
    click_buttons(["0", "0", "1", "6", "2", "7"])
    message_box = find_widget_by_text("Game Over")
    expect(message_box).to be_kind_of(Qt::MessageBox)
  end

  xit 'allows a player to play a new game' do 
    display.create_buttons(board)
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
    display.children.find {|d| d.object_name == name}
  end

  def find_widget_by_text(name) 
    display.children.find {|d| d.text == name}
  end
end
