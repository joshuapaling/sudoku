require_relative 'sudoku'

s = Sudoku.new(EVIL2)
s.solve!
s.pretty_print
