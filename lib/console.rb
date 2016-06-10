class Console

  def initialize(input, output)
    @input = input
    @output = output
  end

  def get_valid_input
    input = @input.gets.chomp.to_i
  end

  def show_output(message)
    @output.puts message
  end

  def greeting_message
    show_output("Tic Tac Toe")
  end

  def end_of_game_message
    @output.puts"Game Over"
  end

  def clear_screen
    @output.puts "\e[H\e[2J"
  end

  def ask_board_size
    @output.puts "Hi please choose a board size"
  end
end
