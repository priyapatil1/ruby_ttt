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

  def find_widget(name) 
    display.children.find {|d| d.object_name == name}
  end

  it 'is a window' do
    expect(display).to be_kind_of(Qt::Widget)
    expect(display.parent).to be_nil
  end

  it 'has a title' do
    expect(display.windowTitle).to eq("Tic Tac Toe")
  end

  it "has a grid layout" do
    expect(display.find_child(Qt::GridLayout, 'grid')).to be_kind_of(Qt::GridLayout)
  end

  it 'has a size of 3 x 3' do
    expect(display.find_child(Qt::GridLayout, 'grid').columnCount).to eq 3 
  end

  it 'can changes display when button is clicked' do
    display.create_buttons
    first_cell = find_widget("1")
    first_cell.click
    expect(first_cell.text).to eq "X" 
  end

  it 'creates a grid display based on the size of the board' do
    expect(display.size).to eq 2
  end

  private 

  def click_buttons(buttons)
    buttons.each do |button|
      find_widget(button).click
    end
  end

end
