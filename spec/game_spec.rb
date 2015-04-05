require 'spec_helper'

def check_can_solve(puzzle, solution = nil)
  s = Sudoku::Game.new(puzzle, solution)
  s.solve!
  expect(s.solved?).to be true
  s.pretty_print
end

describe Sudoku::Game do

  describe "#row" do
   it 'returns scope with array of correct cells' do
      @game = Sudoku::Game.new(EASY1)
      row = @game.row(1)
      expect(row.cells[0].val).to eq(nil)
      expect(row.cells[1].val).to eq(2)
      expect(row.cells[5].val).to eq(3)
   end
  end

  describe "#col" do
   it 'returns scope with array of correct cells' do
      @game = Sudoku::Game.new(EASY1)
      col = @game.col(2)
      expect(col.cells[0].val).to eq(2)
      expect(col.cells[1].val).to eq(nil)
      expect(col.cells[7].val).to eq(9)
   end
  end

  describe "#box" do
   it 'returns scope with array of correct cells' do
      @game = Sudoku::Game.new(EASY1)
      box = @game.box(1,2)
      expect(box.cells[2].val).to eq(2)
      expect(box.cells[5].val).to eq(6)
      expect(box.cells[8].val).to eq(nil)
   end
  end

  describe '#cell_at' do
    it 'should return the right cell' do
      @game = Sudoku::Game.new(EASY1)
      expect(@game.cell_at(2,1).val).to eq(2)
      expect(@game.cell_at(8,1).val).to eq(5)
    end
  end

  describe '#solved?' do
    it 'should return false if not solved' do
      @game = Sudoku::Game.new(EASY1)
      expect(@game.solved?).to eq(false)
    end

    it 'should return true if solved' do
      @game = Sudoku::Game.new(EASY1_SOLUTION)
      expect(@game.solved?).to eq(true)
    end
  end


  describe '#unsolved_cells' do
    it 'should return correct no of unsolved cells' do
      @game = Sudoku::Game.new(EASY1)
      expect(@game.unsolved_cells.count).to eq(46)
    end
  end

  describe '#set_initial_state' do
    it 'imports a game correctly' do
      @game = Sudoku::Game.new(EASY1)
      # set_initial_state is called on #initialize
      val = @game.cell_at(2,1).val
      expect(val).to eq(2)
      val = @game.cell_at(1,8).val
      expect(val).to eq(7)
    end
  end

  describe "#solve!" do
    # it "solves an easy puzzle" do
    #   check_can_solve(EASY1, EASY1_SOLUTION)
    # end
    #
    # it "solves a medium puzzle" do
    #   check_can_solve MEDIUM1
    # end
    #
    # it "solves hard puzzles" do
    #   check_can_solve HARD1
    #   check_can_solve HARD2
    #   check_can_solve HARD3
    # end
    #
    # it "solves evil puzzles" do
    #   check_can_solve EVIL1
    #   check_can_solve EVIL2
    # end

    # it "solves really evil puzzles" do
    #   check_can_solve EVIL3
    # end
  end

end
