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

options '/diybiohi.json' do
  allow_cors
  halt 200
end

# json endpoint for all tweets
get '/tweets.json' do
  allow_cors
  content_type "application/json"
  tweets_collection.find.limit(30).sort({tweet_id: -1}).to_a.to_json
end

# json endpoint for only #diybiohi tweets. 
# TODO put these in their own collection
# TODO need to only return tweets from current postcard period
# TODO regex pattern is not efficient
# TODO need to de-dupe tweets or look for re-tweets?
# Also see 
# 	http://docs.mongodb.org/ecosystem/tutorial/model-data-for-ruby-on-rails/
# 	https://github.com/mongodb/mongo-ruby-driver/wiki/Tutorial
get '/diybiohi.json' do
  allow_cors
  content_type "application/json"
  tweets_collection.find("text" => {"$regex" => '.*diybiohi.*'}).sort(:time => :desc).limit(15).to_a.to_json
end

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end
