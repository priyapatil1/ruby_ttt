require 'spec_helper'
require 'main_menu'
require 'qt_helpers'

describe MainMenu do
  before(:all) do
    app = Qt::Application.new(ARGV)
  end

  let(:menu) {MainMenu.new}

  describe 'main menu window' do
    it 'is a window' do
      expect(menu).to be_kind_of(Qt::Widget)
      expect(menu.parent).to be_nil
    end

    it 'has a title' do
      expect(menu.windowTitle).to eq("Tic Tac Toe: Main Menu")
    end

    it 'has a default size' do
      expect(menu.height).to eq(1605)
      expect(menu.width).to eq(1605)
    end

    it "has a horizontal layout" do
      expect(menu.find_child(Qt::HBoxLayout, 'options')).to be_kind_of(Qt::HBoxLayout)
    end

    it 'it has a Human v Human option' do
      expect(menu.find_child(Qt::PushButton, 'hvh')).to be_kind_of(Qt::PushButton)
    end

    it 'has a Human v Computer option' do
      expect(menu.find_child(Qt::PushButton, 'hvc')).to be_kind_of(Qt::PushButton)
    end
  end

  describe 'options being chosen' do
    it 'creates a new window if hvh option chosen' do
      expect(menu.find_child(Qt::PushButton, 'hvh').click).to eq(menu.three_by_three)
    end

    it 'creates a new window if hvc option chosen' do
      expect(menu.find_child(Qt::PushButton, 'hvc').click).to eq(menu.three_by_three)
    end

    it 'creates a new window if cvh option chosen' do
      expect(menu.find_child(Qt::PushButton, 'cvh').click).to eq(menu.three_by_three)
    end
  end
end
