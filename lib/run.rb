require_relative 'sudoku'

s = Sudoku.new(EVIL1)
s.solve!
s.pretty_print
