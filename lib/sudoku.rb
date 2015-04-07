begin
  require "pry"
rescue LoadError
end

require 'colorize'
require 'sudoku/game'
require 'sudoku/cell'
require 'sudoku/scope'
require 'sudoku/pretty_printer'
require 'sudoku/techniques/elimination'
require 'sudoku/techniques/hidden_single'
require 'sudoku/techniques/naked_pair'
require 'sudoku/techniques/naked_subset'
require 'sudoku/techniques/locked_candidate'
require 'sudoku/examples'
require 'sudoku/web'

module Sudoku
end
