require_relative './shared_config'
require_relative './tweet_saver'
require 'nokogiri'
require 'open-uri'

url = "https://twitter.com/search?q=%23diybiohi&src=typd"
css_selector = '.tweet-text'

html = open(url).read
doc = Nokogiri::HTML(html)

tweets = doc.css('div.content').map do |content|
  tweet_id = content.css('a.js-permalink').attr('href').value.scan(/\d+$/).first.to_i
  username = content.css('span.username').text
  time     = Time.at(content.css('span[data-time]').attr('data-time').value.to_i).to_datetime.to_s # sec-from-epoch to ISO8601
  text     = content.css('p.tweet-text').text

  {
    tweet_id: tweet_id,
    username: username,
    time:     time,
    text:     text
  }
end

TweetSaver.new.save(tweets)
