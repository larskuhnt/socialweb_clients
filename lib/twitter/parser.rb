module Twitter

  class Parser

    def self.parse_statuses(feed)
      res = []
      doc = Hpricot(feed)
      (doc/"status").each do |entry|
        res << parse_status(entry)
      end
      return res
    end

    def self.parse_status(entry)
      tweet = Tweet.new
      tweet.text = entry.at('text').inner_html
      tweet.created_at = Time.zone.parse(entry.at('created_at').inner_html)
      tweet.source = entry.at('source').inner_html
      tweet.id = entry.at('id').inner_html
      tweet.user_id = entry.at('user id').inner_html
      tweet.user_image_url = entry.at('user profile_image_url').inner_html
      return tweet
    end
    
  end

end