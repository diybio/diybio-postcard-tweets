require_relative './shared_config'
require 'json'
require 'sinatra'

def allow_cors
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Access-Control-Allow-Methods"] = "GET, OPTIONS"
end

options '/tweets.json' do
  allow_cors
  halt 200
end

# limit query to most recent 8 tweets
get '/tweets.json' do
  allow_cors
  content_type "application/json"
  tweets_collection.find.limit(8).sort({tweet_id: -1}).to_a.to_json
end

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end
