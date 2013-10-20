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

get '/tweets.json' do
  allow_cors
  content_type "application/json"
  tweets_collection.find.to_a.to_json
end

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end
