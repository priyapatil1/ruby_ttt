class ConsoleGame

  attr_reader :console

  def initialize(game, console)
    @game = game
    @console = console
  end

  def game_loop
    console.show_output(display)
    while
      !@game.game_over?
      @game.mark_board
      console.clear_screen
      console.show_output(display)
    end
    console.end_of_game_message
  end

  private

  def display
    size = @game.board.cells.length
    @game.board.cells.each_slice(Math.sqrt(size))
    .flat_map{|line| [line, "\n"]}.join("")
  end

end
