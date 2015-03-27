require 'spec_helper'

describe Sudoku::CellGroup do
  before :each do
    s = Sudoku::Game.new
    @c1 = Sudoku::Cell.new(1,1,0,s)
    @c2 = Sudoku::Cell.new(1,1,0,s)
    @c3 = Sudoku::Cell.new(1,1,0,s)
    @c1.candidates = [1,2,3]
    @c2.candidates = [1,2]
    @c3.candidates = [1,2,4]
    cells = [@c1, @c2, @c3]

    @cell_group = Sudoku::CellGroup.new cells
  end

  describe "#candidates_outside_of" do
    it "finds a candidate that is the only instance of that candidate" do
      candidates = @cell_group.candidates_outside_of @c1
      expect(candidates).to eq([1,2,4])
    end
  end

end