Dir[File.join(File.dirname(__FILE__), "../models", "*.rb")].each { |f| require f }
Dir[File.join(File.dirname(__FILE__), "../lib", "*.rb")].each { |f| require f }

ActiveRecord::Base.logger = Logger.new(STDOUT)
configuration = YAML::load(IO.read('config/database.yml'))
begin
ActiveRecord::Base.establish_connection(configuration['development'])
DB = ActiveRecord::Base.connection

  puts "CONNECTED" if ActiveRecord::Base.connected?
  puts "NOT CONNECTED" unless ActiveRecord::Base.connected?
rescue
  puts "NOT CONNECTED to the database"
end
