require 'spec_helper'

describe Sudoku::Techniques::HiddenSingle do
  describe '#call' do
    it "doesn't eliminate candidates when there's no hidden single" do
      game = Sudoku::Game.new(EASY1, EASY1_SOLUTION)
      cell = game.cell_at(1,1)
      Sudoku::Techniques::HiddenSingle.call(cell)
      expect(cell.candidates.sort).to eq([1,2,3,4,5,6,7,8,9])
    end
  end

  describe '#hidden_single_for_scope' do
    it "solves cell if there's a hidden single" do
      @game = Sudoku::Game.new
      @c1 = Sudoku::Cell.new(1,1,nil,@game)
      @c2 = Sudoku::Cell.new(1,1,nil,@game)
      @c3 = Sudoku::Cell.new(1,1,nil,@game)
      @c1.eliminate_candidates([4,5,6,7,8,9]) # remaining: 1,2,3
      @c2.eliminate_candidates([3,4,5,6,7,8,9]) # remaining: 1,2
      @c3.eliminate_candidates([3,5,6,7,8,9]) # remaining: 1,2,4
      cells = [@c1, @c2, @c3]

      @scope = Sudoku::Scope.new(cells)
      technique = Sudoku::Techniques::HiddenSingle.new(@c1)
      technique.hidden_single_for_scope(@scope)
      expect(@c1.val).to be(3)
    end
  end
end
