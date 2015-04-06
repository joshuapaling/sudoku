require 'spec_helper'

describe Sudoku::Game do
  describe '#eliminate_for_scope' do
    it 'eliminates correct candidates' do
      game = Sudoku::Game.new(EASY1, EASY1_SOLUTION)
      cell = game.cell_at(1,1)
      Sudoku::Techniques::Elimination.call(cell)
      expect(cell.candidates.sort).to eq([1,4,6,8])
    end

    it 'solves when it eliminates all candidates' do
      game = Sudoku::Game.new(EASY1, EASY1_SOLUTION)
      cell = game.cell_at(4,6)
      Sudoku::Techniques::Elimination.call(cell)
      expect(cell.val).to eq(1)
    end
  end
end
