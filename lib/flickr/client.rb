module Flickr

  class Client

    BASE_URL = "http://api.flickr.com/services/rest"
    DEFAULT_PARAMS = { :api_key => "", :format => "rest" }
    FEED_URLS = {
      :list_photosets => "#{BASE_URL}?method=flickr.photosets.getList&%s"
    }

    def self.photosets(options = {})
      options = DEFAULT_PARAMS.merge(options)
      feed = open(format("#{FEED_URLS[:list_photosets]}", options.to_param)).read
      Flickr::Parser.parse_photosets(feed, options[:user_id])
    end

  end
  
end