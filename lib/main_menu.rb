require 'qt'

class MainMenu < Qt::Widget
  EMPTY_3x3   = ["-", "-", "-",
                 "-", "-", "-",
                 "-", "-", "-"]

  slots :click_hvh, :click_hvc, :click_cvh

  attr_reader :three_by_three

  DEFAULT_MENU_SIZE = 1605

  def initialize
    super(nil)
    setup_layout
    setup_game_options_buttons
    setup_main_menu
  end

  def setup_game_options_buttons
    options = [create_hvh , create_hvc, create_cvh]
    options.each { |option|  option }
  end

  private 

  def setup_layout
    @layout = Qt::HBoxLayout.new
    @layout.object_name = "options"
    set_layout(@layout)
  end

  def setup_main_menu
    self.setWindowTitle("Tic Tac Toe: Main Menu")
    self.resize(DEFAULT_MENU_SIZE, DEFAULT_MENU_SIZE)
    self.setStyleSheet("padding: 60px;")
  end

  def create_game_option(name, title, slot)
    button = create_push_button(name, title)
    connect(button, SIGNAL(:clicked), self, SLOT(slot))
    @layout.addWidget(button)
  end

  def create_hvh
    create_game_option("hvh", "Human v Human", :click_hvh)
  end

  def create_hvc
    create_game_option("hvc", "Human v Computer", :click_hvc)
  end

  def create_cvh
    create_game_option("cvh", "Computer v Human", :click_cvh)
  end

  def create_push_button(name, title)
    button = Qt::PushButton.new
    button.object_name = name
    button.setStyleSheet(stylesheet)
    button.setText(title)
    button
  end

  def stylesheet
    "border: 3px solid #129793;
     padding: 30px;"
  end

  def click_hvh
    board = Board.new(EMPTY_3x3) 
    player_x = GuiPlayer.new("X")
    player_o = GuiPlayer.new("O")
    game = Game.new(board, player_x, player_o)
    three_by_three = Gui.new(game)
    three_by_three.show
  end

  def click_hvc
    board = Board.new(EMPTY_3x3) 
    player_x = GuiPlayer.new("X")
    player_o = GuiComputerPlayer.new("O", ComputerPlayer.new("O"))
    game = Game.new(board, player_x, player_o)
    three_by_three = Gui.new(game)
    three_by_three.show
  end

  def click_cvh
    board = Board.new(EMPTY_3x3) 
    player_x = GuiComputerPlayer.new("X", ComputerPlayer.new("X"))
    player_o = GuiPlayer.new("O")
    game = Game.new(board, player_x, player_o)
    three_by_three = Gui.new(game)
    three_by_three.show
  end
end
