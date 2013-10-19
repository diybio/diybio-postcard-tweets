require 'dotenv'
Dotenv.load

require 'mongo'
require 'uri'

def mongo_connection
  return @db_connection if @db_connection
  db = URI.parse(ENV['MONGOHQ_URL'] || ENV['MONGODB_URL'] || raise("Please specify MONGOHQ_URL or MONGODB_URL"))
  db_name = db.path.gsub(/^\//, '')
  @db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
  @db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
  @db_connection
end
