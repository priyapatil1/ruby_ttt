class GuiComputerPlayer

  attr_accessor :next_move
  attr_accessor :previous_move

  def initialize(symbol, computer_player)
    @symbol = symbol
    @computer_player = computer_player
    @previous_move = -1
    @next_move = -2
  end

  def move(board)
    @next_move = @computer_player.move(board)
  end

  def has_move?
    true
  end
  
  def mark 
    @symbol
  end
end
