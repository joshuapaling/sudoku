require 'spec_helper'

describe Sudoku::Scope do
  before :each do
    s = Sudoku::Game.new
    @c1 = Sudoku::Cell.new(1,1,0,s)
    @c2 = Sudoku::Cell.new(1,1,0,s)
    @c3 = Sudoku::Cell.new(1,1,0,s)
    @c1.candidates = [1,2,3]
    @c2.candidates = [1,2]
    @c3.candidates = [1,2,4]
    cells = [@c1, @c2, @c3]

    @scope = Sudoku::Scope.new cells
  end

  describe "#candidates_outside_of" do
    it "finds a candidate that is the only instance of that candidate" do
      candidates = @scope.candidates_outside_of @c1
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