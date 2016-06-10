require 'qt'

class Gui < Qt::Widget
  slots :click
  slots :quit
  slots :four_game
  attr_reader :size

  def initialize(board)
    super(nil)
    self.setWindowTitle("Tic Tac Toe")
    self.setStyleSheet("background-color: #FFF5C3")
    self.resize(1605, 1605)
    @board = board
    @size = Math.sqrt(board.cells.size) - 1
    @current_mark = "images/smiley_face.png" 
    player_x = GuiPlayer.new(self, "X")
    player_o = GuiPlayer.new(self, "O")
    @game = Game.new(@board, player_x, player_o)
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
    menu_heading = @menubar.addMenu "&File"
    three = Qt::Action.new "New 3 x 3 Game", self
    quit = Qt::Action.new "quit", self
    three.set_object_name(" 3 x 3 Option")
    four = Qt::Action.new "New 4 x 4 Game", self
    menu_heading.addAction(three)
    menu_heading.addAction(four)
    menu_heading.addAction(quit)
    @layout.addWidget(@menubar)
    connect(four, SIGNAL(:triggered), self, SLOT(:four_game))
    connect(quit, SIGNAL(:triggered), self, SLOT(:quit))
  end

  def four_game
    Gui.new(Board.new(Array.new(16, "-"))).show
  end


  def create_buttons
    for index in 0..(@board.cells.size - 1) do
      create_button(index)
    end
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

  def click
    current_player = @game.calculate_player
    next_player = @game.switch_players(current_player.mark)
    current_player.next_move = @layout.indexOf(sender)
    if !@game.game_over?
      @current_mark = images
      mark_empty_position(current_player, @current_mark)
      update_status_bar(next_player)
      if @game.game_over?
        show_winner_status(current_player)
      end
    else
      end_of_game_popup(next_player)
    end
  end

  def mark_empty_position(current_player, mark)
    if @game.board.cells[current_player.next_move] == "-"
      @game.mark_board
      sender.setStyleSheet("background-image: url(" + mark + ");
                           background-repeat: no-repeat;
                           background-size: 480px;
                           background-position: center;")
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

  def quit
    exit
  end

  def images
     @current_mark == "images/smiley_face.png" ? "images/glasses_face.png" : "images/smiley_face.png"
  end

end
