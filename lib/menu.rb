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
    @console.ask_board_size
    input = get_input(4)
    size = get_input(10)
    created_game = @game_setup.create(input, size)
    @game_setup.start(@console)
  end

  def get_input(size)
    input = @console.get_valid_input
    if !valid_input(input, size)
      get_input(size)
    else
      input
    end
  end

  def valid_input(input, max_size)
    (0..max_size).include?(input)
  end
end
