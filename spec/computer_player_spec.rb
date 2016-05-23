require "computer_player"

describe ComputerPlayer do

  it "has O as a mark" do
    computer = ComputerPlayer.new("O")
    expect(computer.mark).to eq "O"
  end

  it "chooses a winning move first row" do
    board = Board.new(["O", "O", "-",
                       "X", "X", "-",
                       "X", "-", "-"])
    computer = ComputerPlayer.new("O")
    expect(computer.move(board)).to eq 2
  end

  it "chooses a winning move second row"do
    board = Board.new(["X", "X", "-",
                       "O", "O", "-",
                       "X", "-", "-"])
    computer = ComputerPlayer.new("O")
    expect(computer.move(board)).to eq 5 
  end

  it "chooses a winning move in the third row" do
    board = Board.new(["-", "X", "-",
                       "X", "X", "-",
                       "O", "O", "-"])
    computer = ComputerPlayer.new("O")
    expect(computer.move(board)).to eq 8 
  end

  it "chooses a blocking move" do
    board = Board.new(["O", "X", "O",
                       "-", "-", "-",
                       "X", "X", "O"])
    computer = ComputerPlayer.new("O")
    expect(computer.move(board)).to eq 4 
  end

  it "chooses a winning move from four empty cells" do
    board = Board.new(["-", "X", "O",
                       "-", "-", "O",
                       "X", "X", "-"])
    computer = ComputerPlayer.new("O")
    expect(computer.move(board)).to eq 8 
  end

  it "plays a winning and blocking move from four empty cells" do
    board = Board.new(["X", "-", "O",
                       "O", "-", "O",
                       "X", "-", "X"])
    computer = ComputerPlayer.new("O")
    expect(computer.move(board)).to eq 4 
  end
end
