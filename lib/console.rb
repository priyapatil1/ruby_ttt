class Console

  def initialize(input, output)
    @input = input
    @output = output
  end

  def get_valid_input(size)
    input = @input.gets.chomp.to_s
    valid(input, size) ? input.to_i : re_enter_input(size)
  end

  def re_enter_input(size)
    valid_input_prompt 
    get_valid_input(size)
  end

  def valid(input, size)
    ("0"..size.to_s).include?(input)
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

  def valid_input_prompt
    @output.puts "Please enter a valid number:"
  end

  def clear_screen
    @output.puts "\e[H\e[2J"
  end

  def ask_board_size
    @output.puts "Hi please choose a board size"
  end
end
