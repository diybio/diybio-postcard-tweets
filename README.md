Tweet poller for the postcard project.  Try the [live deployed JSON endpoint](http://diybio-postcard-tweets.herokuapp.com/tweets.json).

Setup
==============

Get the code:

```
$ git clone git@github.com:diybio/diybio-postcard-tweets.git
$ cd diybio-postcard-tweets
```

Configure your local environment by creating a `.env` file:

```
$ cat .env
TWITTER_CONSUMER_KEY=your-consumer-key-here
TWITTER_CONSUMER_SECRET=your-consumer-secret-here
TWITTER_OAUTH_KEY=your-key-here
TWITTER_OAUTH_SECRET=your-secret-here
MONGODB_URL=mongodb://localhost:27017/your-local-dbname-here
PORT=3000
```

Install dependencies and start:

```
$ bundle
(...)
Your bundle is complete!

$ foreman start
17:18:46 web.1  | started with pid 95407
```

Now you can visit [http://localhost:3000](http://localhost:3000).

Deploy
==============

After pulling down the git repo, add the heroku repo as a remote:

```
git remote add heroku git@heroku.com:diybio-postcard-tweets.git
```

Deploy on Heroku with MongoHQ and scheduler addons.  

```
git push heroku
```

Scheduler addon runs:

`TWITTER_SEARCH=desired-search bundle exec ruby poll_recent.rb`

Leave `TWITTER_SEARCH` blank to default to search term of `#diybiohi`.
