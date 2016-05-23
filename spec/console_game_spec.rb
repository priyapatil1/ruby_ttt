
describe "console game" do
  empty_board = ["-", "-", "-",
                 "-", "-", "-",
                 "-", "-", "-"]

  let(:input) {StringIO.new("3\n0\n1\n2\n3\n4\n5\n6\n")}
  let(:output) {StringIO.new("")}
  let(:console) {Console.new(input, output)}
  let(:player_x) {HumanPlayer.new(console,"X")}
  let(:player_o) {HumanPlayer.new(console,"O")}
  let(:board) {Board.new(empty_board)}

  it "plays a game through to the end" do
    game = Game.new(board, player_x, player_o)
    console_game = ConsoleGame.new(game, console)
    console_game.start
    (expect(output.string.chomp)).to include "Hi please choose a board size"
    (expect(output.string.chomp)).to include "Game Over"
  end

  it "displays the board to user during the game play" do
    game = Game.new(board, player_x, player_o)
    console_game = ConsoleGame.new(game, console)
    console_game.start
    (expect(output.string.chomp)).to include "XOX\nOXO\nX--\n"
  end
end
