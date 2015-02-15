require_relative 'sudoku'

s = Sudoku.new(MEDIUM1)
s.solve!
s.pretty_print
