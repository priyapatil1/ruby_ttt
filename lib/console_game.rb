class ConsoleGame

  attr_reader :console

  def initialize(game, console)
    @game = game
    @console = console
  end

  def start
    @console.greeting_message
    input = console.get_valid_input(10)
    board = @game.create_board(input)
    console.show_output(board.display)
    game_loop
  end

  def game_loop
    console.show_output(@game.board.display)
    while
      !@game.game_over?
      @game.mark_board
      console.clear_screen
      console.show_output(@game.board.display)
    end
    console.end_of_game_message
  end
end
