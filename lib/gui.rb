require 'qt'

class Gui < Qt::Widget
  slots :click
  attr_reader :size

  def initialize(board)
    super(nil)
    self.setWindowTitle("Tic Tac Toe")
    @board = board
    @size = Math.sqrt(board.cells.size) - 1
    player_x = GuiPlayer.new(self, "X")
    player_o = GuiPlayer.new(self, "O")
    @game = Game.new(@board, player_x, player_o)
    @layout = Qt::GridLayout.new
    @layout.object_name = "grid"
    @layout.setColumnMinimumWidth(size, size)
    create_buttons
    set_layout(@layout)
  end

  def create_buttons
    for index in 0..(@board.cells.size - 1) do
      create_button(index)
    end
  end

  def create_button (index)
      button = Qt::PushButton.new
      button.setText("-")
      button.object_name = index.to_s
      button.setSizePolicy(Qt::SizePolicy::Expanding, Qt::SizePolicy::Expanding)
      button.setStyleSheet("border: 3px solid white")
      connect(button, SIGNAL(:clicked), self, SLOT(:click))
      @layout.addWidget(button)
  end

  def click
    current_player = @game.calculate_player
    current_player.next_move = @layout.indexOf(sender)
    @game.mark_board
    sender.setText(current_player.mark)
  end
end
