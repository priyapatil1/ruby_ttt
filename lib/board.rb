class Board

    attr_accessor :cells

    def initialize(cells)
      @cells = cells 
    end

    def mark_at(index)
      cells[index]
    end

    def mark(mark, position)
        new_cells = cells.clone
        new_cells[position] = mark
        Board.new(new_cells)
    end

    def full?
        !cells.include?("-")
    end

    def played_cells
      cells.select { |cell| cell != '-' }
    end

    def positions(mark)
      (0...cells.size).select do |index|
        cells[index] == mark
      end
    end

    def row_indices
      size = cells.size
      row_length = Math.sqrt(size)
      (0..size - 1).each_slice(row_length).to_a
    end

    def column_indices
      row_indices.transpose
    end

    def left_to_right
      size = cells.size
      row_length = Math.sqrt(size)
      (row_length -1).step(size - (row_length -1), row_length -1).to_a
    end

    def right_to_left
      size = cells.size
      row_length = Math.sqrt(size)
      0.step(size - 1, row_length + 1).to_a
    end

    def diagonal_indices
      [left_to_right, right_to_left]
    end

    def winning_combos
      row_indices
      .concat(column_indices)
      .concat(diagonal_indices)
    end

    def win?(mark)
      winning_combos
      .map {|combo| combo.all? {|position| 
        @cells[position] == mark}}
      .include? true
    end

    def any_win?
      win?("X") || win?('O')
    end
end
