require 'spec_helper'

describe Sudoku::Techniques::NakedPair do
  describe '#call' do
    it "doesn't eliminate candidates when there's no naked pair" do
      game = Sudoku::Game.new(EASY1, EASY1_SOLUTION)
      cell = game.cell_at(1,1)
      Sudoku::Techniques::NakedPair.call(cell)
      expect(cell.candidates.sort).to eq([1,2,3,4,5,6,7,8,9])
    end
  end

  describe '#naked_pair_in_scope' do
    it "solves cell if there's a naked pair" do
      @game = Sudoku::Game.new
      @c1 = Sudoku::Cell.new(1,1,nil,@game)
      @c2 = Sudoku::Cell.new(1,1,nil,@game)
      @c3 = Sudoku::Cell.new(1,1,nil,@game)
      @c1.eliminate_candidates([3,4,5,6,7,8,9]) # remaining: 1,2
      @c2.eliminate_candidates([3,4,5,6,7,8,9]) # remaining: 1,2
      @c3.eliminate_candidates([3,5,6,7,8,9]) # remaining: 1,2,4
      cells = [@c1, @c2, @c3]

      @scope = Sudoku::Scope.new(cells)
      technique = Sudoku::Techniques::NakedPair.new(@c1)
      technique.naked_pair_in_scope(@scope)
      expect(@c3.val).to be(4)
    end
  end
end
