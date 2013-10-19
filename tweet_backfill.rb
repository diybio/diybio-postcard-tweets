require_relative './shared_config'
require 'nokogiri'
require 'open-uri'

url = "https://twitter.com/search?q=%23diybiohi&src=typd"
css_selector = '.tweet-text'

html = open(url).read
doc = Nokogiri::HTML(html)

tweets = doc.css('div.content').map do |content|
  username = content.css('span.username').text
  time     = content.css('span[data-time]').attr('data-time').value
  tweet    = content.css('p.tweet-text').text
  id       = content.css('a.js-permalink').attr('href').value.scan(/\d+$/).first.to_i

  [id, username, time, tweet]
end
