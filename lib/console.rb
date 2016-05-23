class Console

  def initialize(input, output)
    @input = input
    @output = output
  end

  def get_valid_input(size)
    input = @input.gets.chomp.to_s
    if ("0"..size.to_s).include?(input)
      input = input.to_i
    else
      @output.puts "Please enter a valid number:"
      get_valid_input(size)
    end
  end

  def show_output(message)
    @output.puts message
  end

  def greeting_message
    show_output("Hi please choose a board size")
  end

  def end_of_game_message
    show_output("Game Over")
  end

  def clear_screen
    @output.puts "\e[H\e[2J"
  end
end
