require 'spec_helper'

describe Sudoku::Techniques::NakedSubset do
  describe '#call' do
    it "doesn't eliminate candidates when there's no naked group" do
      game = Sudoku::Game.new(EASY1, EASY1_SOLUTION)
      cell = game.cell_at(1,1)
      Sudoku::Techniques::NakedSubset.call(cell)
      expect(cell.candidates.sort).to eq([1,2,3,4,5,6,7,8,9])
    end
  end

  describe '#naked_pair_in_scope' do
    it "solves cell if there's a naked triple" do
      @game = Sudoku::Game.new
      @c1 = Sudoku::Cell.new(1,1,nil,@game)
      @c2 = Sudoku::Cell.new(1,1,nil,@game)
      @c3 = Sudoku::Cell.new(1,1,nil,@game)
      @c4 = Sudoku::Cell.new(1,1,nil,@game)

      # The naked triple of values 1,2,3:
      @c1.eliminate_candidates([4,5,6,7,8,9]) # remaining: 1,2,3
      @c2.eliminate_candidates([3,4,5,6,7,8,9]) # remaining: 1,2
      @c3.eliminate_candidates([1,4,5,6,7,8,9]) # remaining: 2,3

      # The cell outside the naked triple
      @c4.eliminate_candidates([1,5,6,7,8,9]) # remaining: 2,3,4

      cells = [@c1, @c2, @c3, @c4]

      @scope = Sudoku::Scope.new(cells)
      technique = Sudoku::Techniques::NakedSubset.new(@c1)
      technique.naked_subset_in_scope(3, @scope)
      expect(@c4.val).to be(4)
    end

    it "doesn't count solved cells in naked subset" do
      @game = Sudoku::Game.new
      @c1 = Sudoku::Cell.new(1,1,nil,@game)
      @c2 = Sudoku::Cell.new(1,1,nil,@game)
      @c3 = Sudoku::Cell.new(1,1,nil,@game)
      @c4 = Sudoku::Cell.new(1,1,nil,@game)

      # The naked triple of values 1,2,3:
      @c1.eliminate_candidates([4,5,6,7,8,9]) # remaining: 1,2,3
      @c2.eliminate_candidates([3,4,5,6,7,8,9]) # remaining: 1,2
      @c3.eliminate_candidates([1,2,3,4,5,6,7,8]) # remaining: nothing (it's solved)

      # The cell outside the naked triple
      @c4.eliminate_candidates([1,5,6,7,8,9]) # remaining: 2,3,4

      cells = [@c1, @c2, @c3, @c4]

      @scope = Sudoku::Scope.new(cells)
      technique = Sudoku::Techniques::NakedSubset.new(@c1)
      technique.naked_subset_in_scope(3, @scope)
      expect(@c4.val).to be(nil)
    end

    it "solves cell if there's a naked quad" do
      @game = Sudoku::Game.new
      @c1 = Sudoku::Cell.new(1,1,nil,@game)
      @c2 = Sudoku::Cell.new(1,1,nil,@game)
      @c3 = Sudoku::Cell.new(1,1,nil,@game)
      @c4 = Sudoku::Cell.new(1,1,nil,@game)
      @c5 = Sudoku::Cell.new(1,1,nil,@game)

      # The naked triple of values 1,2,3:
      @c1.eliminate_candidates([5,6,7,8,9]) # remaining: 1,2,3,4
      @c2.eliminate_candidates([4,5,6,7,8,9]) # remaining: 1,2,3
      @c3.eliminate_candidates([1,5,6,7,8,9]) # remaining: 2,3,4
      @c4.eliminate_candidates([5,6,7,8,9]) # remaining: 1,2,3,4

      # The cell outside the naked quad
      @c5.eliminate_candidates([6,7,8,9]) # remaining: 1,2,3,4,5

      cells = [@c1, @c2, @c3, @c4, @c5]

      @scope = Sudoku::Scope.new(cells)
      technique = Sudoku::Techniques::NakedSubset.new(@c1)
      technique.naked_subset_in_scope(4, @scope)
      expect(@c5.val).to be(5)
    end
  end
end
