require 'spec_helper'

describe Sudoku::PrettyPrinter do
  before :each do
    @game = Sudoku::Game.new(EMPTY)
    @pp = Sudoku::PrettyPrinter.new
  end

  describe '#print_row' do
    it "connects cells correctly" do
      expected = <<EOT
------------------------------------------------------------------------
 1 2 3 | 1 2 3 | 1 2 3 | 1 2 3 | 1 2 3 | 1 2 3 | 1 2 3 | 1 2 3 | 1 2 3 |
 4 5 6 | 4 5 6 | 4 5 6 | 4 5 6 | 4 5 6 | 4 5 6 | 4 5 6 | 4 5 6 | 4 5 6 |
 7 8 9 | 7 8 9 | 7 8 9 | 7 8 9 | 7 8 9 | 7 8 9 | 7 8 9 | 7 8 9 | 7 8 9 |
EOT
      row = @game.row(1)
      expect(@pp.print_row(row)).to eq(expected)
    end
  end

  describe '#print_cell' do
    it 'works for cell with all candidates' do
      expected = <<EOT
--------
 1 2 3 |
 4 5 6 |
 7 8 9 |
EOT
      cell = Sudoku::Cell.new(1, 1, nil, @game)
      expect(@pp.print_cell(cell)).to eq(expected)
    end

    it 'works for cell with some candidates' do
      expected = <<EOT
--------
 - 2 - |
 4 5 6 |
 - - 9 |
EOT
      cell = Sudoku::Cell.new(1, 1, nil, @game)
      cell.eliminate_candidates([1,3,7,8])
      expect(@pp.print_cell(cell)).to eq(expected)
    end

    it 'works for solved cell' do
      expected = <<EOT
--------
 ` ` ` |
 ` 9 ` |
 ` ` ` |
EOT
      cell = Sudoku::Cell.new(1, 1, 9, @game)
      expect(@pp.print_cell(cell)).to eq(expected)
    end

  end
end