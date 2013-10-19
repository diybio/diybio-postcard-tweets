require_relative './shared_config'
require 'twitter'

Twitter.configure do |config|
  config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
  config.oauth_token         = ENV['TWITTER_OAUTH_KEY']
  config.oauth_token_secret  = ENV['TWITTER_OAUTH_SECRET']
end

# Twitter.middleware.insert_after Twitter::Response::RaiseError, Faraday::Response::Logger

class RecentRestSearcher
  def initialize(term)
    @term = term
  end

  def recent_tweets
    search = Twitter.search(@term, { count: 100 })
    search.results.map do |status|
      {
        tweet_id: status.id,
        username: status.user.screen_name,
        time:     DateTime.parse(status.created_at).to_s,
        text:     status.full_text
      }
    end
  end

  def recent_tweets_multi_page
    params = { count: 100 }
    tweets = []

    loop do
      search = Twitter.search(@term, params)
      search.results.each do |status|
        tweets << [status.id, status.user.screen_name, DateTime.parse(status.created_at).to_s, status.full_text]
      end

      break unless search.next_results?

      params = search.next_results
    end

    tweets
  end
end

tweets = RecentRestSearcher.new(ENV['TWITTER_SEARCH'] || "#diybiohi").recent_tweets

p tweets
