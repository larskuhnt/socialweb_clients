module YouTube

  class Client

    BASE_URL = "http://gdata.youtube.com/feeds/api/"
    DEFAULT_PARAMS = { "v" => 2, "max-results" => 5, "format" => 5 }
    FEED_URLS = {
      :user_uploads => "#{BASE_URL}users/%s/uploads?%s"
    }

    def self.user_uploads(user, options = {})
      options = DEFAULT_PARAMS.merge(options)
      feed = open(format(FEED_URLS[:user_uploads], user, options.to_param)).read
      YouTube::Parser.parse(feed)
    end

  end

end