require 'spec_helper'

describe Sudoku::Scope do
  before :each do
    @game = Sudoku::Game.new
    @c1 = Sudoku::Cell.new(1,1,nil,@game)
    @c2 = Sudoku::Cell.new(1,1,nil,@game)
    @c3 = Sudoku::Cell.new(1,1,nil,@game)
    @c1.eliminate_candidates([4,5,6,7,8,9]) # remaining: 1,2,3
    @c2.eliminate_candidates([3,4,5,6,7,8,9]) # remaining: 1,2
    @c3.eliminate_candidates([3,5,6,7,8,9]) # remaining: 1,2,4
    cells = [@c1, @c2, @c3]

    @scope = Sudoku::Scope.new(cells)
  end

  describe "#candidates_outside_of" do
    it "finds correct candidates" do
      candidates = @scope.candidates_outside_of(@c1)
      expect(candidates).to eq([1,2,4])
    end
  end

  describe "#cells_other_than" do
    it "returns all cells other than the one specified" do
      cells = @scope.cells_other_than(@c3)
      expect(cells).to eq([@c1, @c2])
    end
  end

end
