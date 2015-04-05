require 'spec_helper'

describe Sudoku::Cell do
  before :each do
    @game = Sudoku::Game.new(EASY1)
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

end
