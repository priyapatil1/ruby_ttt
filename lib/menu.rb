require "game_setup"

class Menu

  def initialize(console)
    @console = console 
    @game_setup = GameSetup.new(@console)
  end

  def display_choices
    "1) Human v Human\n" +
    "2) Human v Computer\n" +
    "3) Computer v Human\n" +
    "4) Computer v Computer\n"
  end

  def start
    @console.greeting_message
    @console.show_output(display_choices)
    input = @console.get_valid_input(10)
    @console.ask_board_size
    size = @console.get_valid_input(10)
    created_game = @game_setup.create(input, size)
    @game_setup.start(@console)
  end
end
