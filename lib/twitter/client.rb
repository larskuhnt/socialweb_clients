module Twitter

  class Client
    
    BASE_URL = "https://twitter.com/"
    DEFAULT_PARAMS = { :count => 9, :format => "xml" }
    FEED_URLS = {
      :user_timeline => "#{BASE_URL}statuses/user_timeline/%s.%s?%s"
    }

    def self.user_timeline(user_id, options = {})
      options = DEFAULT_PARAMS.merge(options)
      feed = open(format(FEED_URLS[:user_timeline], user_id, options.delete(:format), options.to_param)).read
      Twitter::Parser.parse_statuses(feed)
    end

  end

end