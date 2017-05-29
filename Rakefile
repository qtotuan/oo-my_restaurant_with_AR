require_relative 'app'
require 'sinatra/activerecord/rake'


# desc "Run Migrations"
# namespace :db do
#   task :migrate do
#     ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
#   end
# end

desc "load my app.rb and open pry"
task :console do
  require 'pry'
  # exec "pry -r ./app.rb"
  Pry.start
end

desc "run app.rb"
task :run do
  CLI.new.start
  #exec "./app.rb"
end
