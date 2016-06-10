require 'qt'

class Gui < Qt::Widget
  slots :click
  slots :quit
  slots :four_game
  slots :three_game
  attr_reader :size

  def initialize(board)
    super(nil)
    set_window_dimensions
    @board = board
    @size = Math.sqrt(board.cells.size) - 1
    player_x = GuiPlayer.new(self, "X")
    player_o = GuiPlayer.new(self, "O")
    @game = Game.new(@board, player_x, player_o)
    create_display(size)
  end

  def create_buttons
    for index in 0..(@board.cells.size - 1) do
      create_button(index)
    end
  end

  def click
    current_player = @game.calculate_player
    next_player = @game.switch_players(current_player.mark)
    current_player.next_move = @layout.indexOf(sender)
    if !@game.game_over?
      mark_empty_position(current_player)
      update_status_bar(next_player)
      if @game.game_over?
        show_winner_status(current_player)
      end
    else
      end_of_game_popup(next_player)
    end
  end

  def update_status_bar(next_player)
    @statusbar.showMessage(next_player + "'s turn")
  end

  def show_winner_status(current_player)
    @statusbar.showMessage(current_player.mark + " is the winner!")
  end

  def end_of_game_popup(current_player)
    message_box = Qt::MessageBox.new 
    message_box.text = "Game Over, " + current_player + " has won! Play Again?"
    message_box.setStandardButtons(Qt::MessageBox::No | Qt::MessageBox::Yes)
    message_box.setDefaultButton(Qt::MessageBox::Yes)
    click = message_box.exec
    case click 
    when Qt::MessageBox::Yes
      self.class.new(Board.new(Array.new(@board.cells.size, "-"))).show
    end 
  end

  private

  def create_display(size)
    create_layout(size)
    create_statusbar
    create_menubar
  end

  def create_layout(size)
    @layout = Qt::GridLayout.new
    @layout.object_name = "grid"
    @layout.setColumnMinimumWidth(size, size)
    create_buttons
    set_layout(@layout)
  end

  def create_statusbar
    @statusbar = Qt::StatusBar.new
    @statusbar.object_name = 'game status'
    @statusbar.showMessage("X's turn")
    @layout.addWidget(@statusbar)
  end

  def create_menubar
    @menubar = Qt::MenuBar.new
    @menubar.set_object_name('menu bar')
    @layout.addWidget(@menubar)
    menu_heading = @menubar.addMenu "&File"
    quit = Qt::Action.new "quit", self
    three = Qt::Action.new "New 3 x 3 Game", self
    four = Qt::Action.new "New 4 x 4 Game", self
    menu_heading.addAction(three)
    menu_heading.addAction(four)
    menu_heading.addAction(quit)
    connect(four, SIGNAL(:triggered), self, SLOT(:four_game))
    connect(three, SIGNAL(:triggered), self, SLOT(:three_game))
    connect(quit, SIGNAL(:triggered), self, SLOT(:quit))
  end

  def mark_empty_position(current_player)
    if @game.board.cells[current_player.next_move] == "-"
      @game.mark_board
      sender.setText(current_player.mark)
    end
  end

  def quit
    exit
  end

  def four_game
    Gui.new(Board.new(Array.new(16, "-"))).show
  end

  def three_game 
    Gui.new(Board.new(Array.new(9, "-"))).show
  end

  def create_button (index)
    button = Qt::PushButton.new
    button.object_name = index.to_s
    button.setSizePolicy(Qt::SizePolicy::Expanding, Qt::SizePolicy::Expanding)
    button.setStyleSheet("border: 3px solid #129793;
                         color: #FF7260;
                         font-size: 26px;")
    connect(button, SIGNAL(:clicked), self, SLOT(:click))
    @layout.addWidget(button)
  end

  def set_window_dimensions
    self.setWindowTitle("Tic Tac Toe")
    self.setStyleSheet("background-color: #FFF5C3")
    self.resize(1605, 1605)
  end
end
