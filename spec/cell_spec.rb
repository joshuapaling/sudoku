require 'spec_helper'

describe Sudoku::Cell do
  before :each do
    s = Sudoku::Game.new
    @c1 = Sudoku::Cell.new(1,1,0,s)
    @c1.candidates = [1,2,3]
  end

  describe "#solved" do
    it "" do
      expect(candidates).to eq([1,2,4])
    end
  end

end