require "human_player"
require "computer_player"

class PlayerFactory
  attr_accessor :console

  def initialize(console)
    @console = console
  end

  def make_x(choice)
    choice == 1 || choice == 2 ? HumanPlayer.new(console, "X") : ComputerPlayer.new("X")
  end

  def make_o(choice)
    choice == 1 || choice == 3 ? HumanPlayer.new(console, "O") : ComputerPlayer.new("O")
  end
end
