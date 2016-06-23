require 'qt'
require 'gui_computer_player'

class Gui < Qt::Widget

  slots :click, :quit, :create_4x4, :create_3x3, :play_computer_move, :game_loop

  attr_reader :size
  attr_reader :buttons

  CELLS_4x4 = 16
  CELLS_3x3 = 9 

  def initialize(game)
    super(nil)
    @game = game
    @board = @game.board
    @size = Math.sqrt(@board.cells.size) - 1
    setup_dimensions
    setup_display(size, @board)
  end

  def click
    clicked_button = @layout.indexOf(sender)
    make_move(clicked_button)
  end

  def game_loop
    while !@game.game_over? && @game.next_player.has_move?
        @game.mark_board
        show_display
    end
    show_display
  end

  def create_buttons(board)
    @buttons = (0..(board.cells.size - 1)).map do |index|
      create_button(index)
    end
  end

  private

  def setup_dimensions
    self.setWindowTitle("Tic Tac Toe: Human v Human")
    self.setStyleSheet("background-color: #FFF5C3")
    self.resize(1605, 1605)
  end

  def setup_display(size, board)
    create_layout(size, board)
    create_statusbar
    setup_menubar
    display_board
  end

  def make_move(clicked_button)
    @game.next_player.next_move = clicked_button
  end

  def delay(time)
    Qt::Timer.singleShot(time, self, SLOT(:play_computer_move))
  end

  def play_computer_move
    @game.mark_board
    show_display
  end

  def show_display
    display_board
    update_status_bar
  end

  def display_board
    @buttons.each_with_index do |button, index|
      button.setText(@game.mark_at(index))
    end
  end

  def update_status_bar
    @statusbar.showMessage(status_message)
  end

  def status_message
    if !@game.game_over?
      @game.next_player.mark + "'s turn"
    else
      @game.previous_player.mark + " is the winner!"
      end_of_game_popup(@game.previous_player.mark)
    end
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
    create_file_menu(menu)
    @layout.addWidget(menu)
  end

  def menubar
    menubar = Qt::MenuBar.new(self)
    menubar.set_object_name('menu bar')
    menubar
  end

  def create_file_menu(menubar)
    @menu_heading = menubar.addMenu "&File"
    quit = Qt::Action.new "quit", self
    three = Qt::Action.new "New 3 x 3 Game", self
    four = Qt::Action.new "New 4 x 4 Game", self
    actions = {quit => :quit, three => :create_3x3, four => :create_4x4}
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
    connect(button, SIGNAL(:clicked), self, SLOT(:game_loop))
    @layout.addWidget(button)
    button
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
      self.class.new(Game.new(Board.new(Array.new(@board.cells.size, "-")), @game.player_x, @game.player_o)).show
    end 
  end

  def message_box_setup(current_player)
    message_box = Qt::MessageBox.new 
    message_box.text = "Game Over, " + current_player + " has won! Play Again?"
    message_box.setStandardButtons(Qt::MessageBox::No | Qt::MessageBox::Yes)
    message_box.setDefaultButton(Qt::MessageBox::Yes)
    message_box
  end

  def create_4x4
    Gui.new(Board.new(Array.new(CELLS_4x4 , "-"))).show
  end

  def create_3x3 
    Gui.new(Board.new(Array.new(CELLS_3x3, "-"))).show
  end

  def quit
    exit
  end
end
