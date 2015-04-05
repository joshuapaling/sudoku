require 'spec_helper'

def check_can_solve(puzzle, solution = nil)
  s = Sudoku::Game.new(puzzle, solution)
  s.solve!
  expect(s.solved?).to be true
  s.pretty_print
end

describe Sudoku::Game do

  describe "#solve!" do
    it 'imports a game correctly' do
      @game = Sudoku::Game.new(EASY1)
      val = @game.cell_at(2,1).val
      expect(val).to eq(2)
      val = @game.cell_at(1,8).val
      expect(val).to eq(7)
    end

    it "solves an easy puzzle" do
      check_can_solve(EASY1, EASY1_SOLUTION)
    end

    it "solves a medium puzzle" do
      check_can_solve MEDIUM1
    end

    it "solves hard puzzles" do
      check_can_solve HARD1
      check_can_solve HARD2
      check_can_solve HARD3
    end

    it "solves evil puzzles" do
      check_can_solve EVIL1
      check_can_solve EVIL2
    end

    # it "solves really evil puzzles" do
    #   check_can_solve EVIL3
    # end
  end

end
