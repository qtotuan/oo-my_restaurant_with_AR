require 'colorize'
require 'active_record'
require 'sqlite3'
require 'logger'
require_relative 'config/environment'

ActiveRecord::Base.logger = Logger.new(STDOUT)
configuration = YAML::load(IO.read('config/database.yml'))
ActiveRecord::Base.establish_connection(configuration['development'])

puts "Hello World, I am running!"
