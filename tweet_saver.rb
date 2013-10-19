require_relative './shared_config'

class TweetSaver
  def initialize
  end

  def save(tweets)
    puts "Previously, we stored #{tweets_collection.size} total tweets"
    puts "Saving #{tweets.size} tweets"

    tweets_inserted = 0
    tweets.each do |tweet|
      if tweets_collection.find(tweet_id: tweet[:tweet_id]).count == 0 
        tweets_collection.insert(tweet)
      end
    end

    puts "Inserted only new tweets, now there are #{tweets_collection.size} total tweets stored"
  end
end
