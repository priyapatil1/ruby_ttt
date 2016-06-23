class GuiPlayer

  attr_accessor :next_move
  attr_accessor :has_move
  attr_accessor :previous_move

  def initialize(symbol)
    @symbol = symbol
    @previous_move = -1
    @next_move = -1
  end

  def move(board)
    @next_move
    move_played
  end

  def move_played
    @previous_move = @next_move
  end

  def has_move?
    @next_move != @previous_move
  end

  def mark
    @symbol
  end
end
