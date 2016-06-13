require 'qt'

class Gui < Qt::Widget
  slots :click, :quit, :four_game, :three_game

  attr_reader :size

  CELLS_4x4 = 16
  CELLS_3x3 = 9 

  def initialize(board)
    super(nil)
    @board = board
    @size = Math.sqrt(board.cells.size) - 1
    setup_dimensions
    create_game(board)
    setup_display(size, board)
  end

  def create_game(board)
    player_x = GuiPlayer.new(self, "X")
    player_o = GuiPlayer.new(self, "O")
    @game = Game.new(board, player_x, player_o)
  end

  def create_buttons(board)
    for index in 0..(board.cells.size - 1) do
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

  private

  def update_status_bar(next_player)
    @statusbar.showMessage(next_player + "'s turn")
  end

  def show_winner_status(current_player)
    @statusbar.showMessage(current_player.mark + " is the winner!")
  end


  def setup_display(size, board)
    create_layout(size, board)
    create_statusbar
    setup_menubar
  end

  def create_layout(size, board)
    @layout = Qt::GridLayout.new
    @layout.object_name = "grid"
    @layout.setColumnMinimumWidth(size, size)
    create_buttons(board)
    set_layout(@layout)
  end

  def create_statusbar
    @statusbar = Qt::StatusBar.new
    @statusbar.object_name = 'game status'
    @statusbar.showMessage("X's turn")
    @layout.addWidget(@statusbar)
  end

  def setup_menubar
    menu = menubar
    create_menu_actions(menu)
    @layout.addWidget(menu)
  end

  def menubar
    menubar = Qt::MenuBar.new(self)
    menubar.set_object_name('menu bar')
    menubar
  end

  def create_menu_actions(menubar)
    @menu_heading = menubar.addMenu "&File"
    quit = Qt::Action.new "quit", self
    three = Qt::Action.new "New 3 x 3 Game", self
    four = Qt::Action.new "New 4 x 4 Game", self
    actions = {quit => :quit, three => :three_game, four => :four_game}
    actions.each do |action, slot| add_actions(action, slot) end
  end

  def add_actions(action, slot)
    @menu_heading.addAction(action)
    connect(action, SIGNAL(:triggered), self, SLOT(slot))
  end

  def mark_empty_position(current_player)
    if @game.board.cells[current_player.next_move] == "-"
      @game.mark_board
      sender.setText(current_player.mark)
    end
  end


  def create_button (index)
    button = Qt::PushButton.new
    button.object_name = index.to_s
    button = style_button(button)
    connect(button, SIGNAL(:clicked), self, SLOT(:click))
    @layout.addWidget(button)
  end

  def style_button(button)
    button.setSizePolicy(Qt::SizePolicy::Expanding, Qt::SizePolicy::Expanding)
    button.setStyleSheet("border: 3px solid #129793;
                         color: #FF7260;
                         font-size: 26px;")
    button

  end

  def end_of_game_popup(current_player)
    click = message_box_setup(current_player).exec
    case click 
    when Qt::MessageBox::Yes
      self.class.new(Board.new(Array.new(@board.cells.size, "-"))).show
    end 
  end

  def message_box_setup(current_player)
    message_box = Qt::MessageBox.new 
    message_box.text = "Game Over, " + current_player + " has won! Play Again?"
    message_box.setStandardButtons(Qt::MessageBox::No | Qt::MessageBox::Yes)
    message_box.setDefaultButton(Qt::MessageBox::Yes)
    message_box
  end

  def setup_dimensions
    self.setWindowTitle("Tic Tac Toe: Human v Human")
    self.setStyleSheet("background-color: #FFF5C3")
    self.resize(1605, 1605)
  end

  def four_game
    Gui.new(Board.new(Array.new(CELLS_4x4 , "-"))).show
  end

  def three_game 
    Gui.new(Board.new(Array.new(CELLS_3x3, "-"))).show
  end

  def quit
    exit
  end
end
