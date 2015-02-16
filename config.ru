require_relative 'lib/web'

use Rack::Reloader, 0

run Rack::Cascade.new([Rack::File.new('public'), Web])