require "player_factory"
require "console_game"
require "gui_player"
require "gui"
require "game"
require "board"

class GameSetup
  attr_accessor :console
  attr_accessor :player_factory
  attr_reader :player_x
  attr_reader :player_o

  def initialize(console)
    @console = console
    @player_factory = PlayerFactory.new(console)
  end

  def create(choice, size)
    board = Board.new(Array.new(size * size, "-")) 
    player_x = player_factory.make_x(choice)
    player_o = player_factory.make_o(choice)
    @game = Game.new(board, player_x, player_o)
  end

  def start(console)
    ConsoleGame.new(@game, console).game_loop
  end
end
