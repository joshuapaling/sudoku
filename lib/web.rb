require 'erb'
require_relative 'sudoku'

class Web

  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
    @sudoku = Sudoku.new(EVIL2)
  end

  def response
    case @request.path
    when '/' then Rack::Response.new(render('index.html.erb'))
    when '/change'
      Rack::Response.new do |response|
        response.set_cookie('greet', @request.params['name'])
        response.redirect('/')
      end
    else Rack::Response.new('not found', 404)
    end
  end

  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def greet_name
    @request.cookies['greet'] || 'world'
  end

end