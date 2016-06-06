class HumanPlayer 
  
    def initialize(console, symbol) 
      @console = console
      @symbol = symbol
    end

    def mark
      @symbol
    end

    def move(board)
      @console.get_valid_input(board.cells.size)
    end
end
