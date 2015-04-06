require 'spec_helper'

describe Sudoku::Cell do
  before :each do
    @game = Sudoku::Game.new(EASY1, EASY1_SOLUTION)
  end

  describe '#row' do
    it 'returns the right row' do
      cell = @game.cell_at(2,1)
      row = @game.row(1)
      expect(cell.row.cells).to eq(row.cells)
    end
  end

  describe '#col' do
    it 'returns the right col' do
      cell = @game.cell_at(2,1)
      col = @game.col(2)
      expect(cell.col.cells).to eq(col.cells)
    end
  end

  describe '#eliminate_candidates' do
    it 'throws exception when eliminating the solution candidate' do
      cell = @game.cell_at(1,1)
      expect { cell.eliminate_candidates([4]) }.to raise_error
    end
  end

end
