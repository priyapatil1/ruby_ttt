class ComputerPlayer

    attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def mark
    symbol
  end

  def switch_players(mark)
    mark == "X" ? "O" : "X"
  end

  def best_move(index, score)
    {:index => index, :score => score}
  end

  def score(board)
    board.any_win? ? 1 : 0
  end

  def negamax(board, depth, symbol, alpha, beta)
    current_best = best_move(- 1, - 100)

    if board.full? || board.any_win? || depth == 0 
      return best_move(- 1, - score(board))
    end

    board.positions("-").each do |position|
      new_board = board.mark(symbol, position)
      new_score = negamax(new_board, depth - 1, switch_players(symbol), - beta, - alpha) 
      temp_score = (- new_score[:score])
      if temp_score > current_best[:score]
        current_best[:index] = position
        current_best[:score] = temp_score 
      end

      alpha = [alpha, current_best[:score]].max
      break if alpha > beta
    end

    best_move(current_best[:index], current_best[:score])
  end

  def move(board)
    negamax(board, 7, symbol, - 100, 100)[:index]
  end
end
