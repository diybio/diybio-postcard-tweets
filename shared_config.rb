require 'dotenv'
Dotenv.load

require 'mongo'

def mongo_client
  uri = ENV['MONGOHQ_URL'] || ENV['MONGODB_URL'] || raise("Please specify MONGOHQ_URL or MONGODB_URL")
  @mongo_client ||= Mongo::MongoClient.from_uri(uri)
end

def tweets_collection
  uri = ENV['MONGOHQ_URL'] || ENV['MONGODB_URL'] || raise("Please specify MONGOHQ_URL or MONGODB_URL")
  parsed_uri = Mongo::URIParser.new(uri)
  database_name = parsed_uri.instance_variable_get("@db")
  @tweets_collection ||= mongo_client[database_name]['tweets']
end
