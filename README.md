Tweet poller for the postcard project:

[http://diybio-postcard-tweets.herokuapp.com/tweets.json]


Setup
==============

```
$ git clone git@github.com:diybio/diybio-postcard-tweets.git
$ cd diybio-postcard-tweets

$ cat .env
TWITTER_CONSUMER_KEY=your-consumer-key-here
TWITTER_CONSUMER_SECRET=your-consumer-secret-here
TWITTER_OAUTH_KEY=your-key-here
TWITTER_OAUTH_SECRET=your-secret-here
MONGODB_URL=mongodb://localhost:27017/your-local-dbname-here

$ bundle
(...)
Your bundle is complete!

$ foreman start
17:18:46 web.1  | started with pid 95407
```
