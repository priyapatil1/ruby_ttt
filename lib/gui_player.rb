class GuiPlayer

  attr_accessor :next_move

  def initialize(gui, symbol)
    @gui = gui
    @symbol = symbol
  end

  def move(board)
    next_move
  end

  def mark
    @symbol
  end
end
