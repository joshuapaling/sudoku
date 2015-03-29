lib_dir = File.expand_path(File.join(File.dirname(__FILE__), "lib"))
$: << lib_dir

require 'sudoku'

use Rack::Reloader, 0

run Rack::Cascade.new([Rack::File.new('public'), Web])