require "spec_helper"
require "board"

describe Board do

    empty_three = ["-", "-", "-",
                   "-", "-", "-",
                   "-", "-", "-"]

    empty_four  = ["-", "-", "-", "-",
                   "-", "-", "-", "-",
                   "-", "-", "-", "-",
                   "-", "-", "-", "-"]

    empty_five  = ["-", "-", "-", "-", "-",
                   "-", "-", "-", "-", "-",
                   "-", "-", "-", "-", "-",
                   "-", "-", "-", "-", "-",
                   "-", "-", "-", "-", "-"]

    marked_board = ["-", "-", "-",
                    "O", "X", "O",
                    "X", "O", "-"]

    full_board = ["O", "O", "X",
                  "X", "X", "O",
                  "O", "X", "X"]

    win_for_x =  ["O", "O", "X",
                  "X", "X", "X",
                  "O", "O", "X"]


    it "can get empty positions on a board" do
        board = Board.new(empty_three)
        expect(board.positions("-")).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
    end

    it "can tell if the board is full" do
        board = Board.new(full_board)
        expect(board.full?).to eq(true)
    end

    it "can calculate row indices" do
        board = Board.new(empty_three)
        expect(board.row_indices).to eq([[0, 1, 2], [3, 4, 5], [6, 7, 8]])
    end

    it "can calculate column indices for 3 x 3" do
        board = Board.new(empty_three)
        expect(board.column_indices).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
    end

    it "can calculate column indices for 4 x 4" do
        board = Board.new(empty_four)
        expect(board.column_indices).to eq([[0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15]])
    end

    it "can calculate diagonal indices for 3 x 3 board" do
        board  = Board.new(empty_three)
        expect(board.diagonal_indices).to eq([[2, 4, 6], [0, 4, 8]])
    end

    it "can calculate diagonals for 4 x 4 board" do
        board = Board.new(empty_four)
        expect(board.diagonal_indices).to eq([[3, 6, 9, 12], [0, 5, 10, 15]])
    end

    it "can calculate diagonals for 5 x 5 board" do
        board = Board.new(empty_five)
        expect(board.diagonal_indices).to eq([[4, 8, 12, 16, 20], [0, 6, 12, 18, 24]])
    end

    it "combines all winning indices" do
        board = Board.new(empty_three)
        expect(board.winning_combos).to eq([[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8],[2, 4, 6], [0, 4, 8]])
    end

    it "can get indices for a certain mark" do
        board = Board.new(marked_board)
        (expect(board.positions("X")).to eq([4, 6]))
    end

    it "can find a row win" do
        board = Board.new(win_for_x)
        (expect(board.win?("X")).to eq(true))
    end

    it "can find any win" do
        board = Board.new(win_for_x)
        (expect(board.any_win?).to eq true)
    end
end
