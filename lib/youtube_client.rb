module YouTube

  class Client

    OPEN_URI_OPTIONS = {
      :proxy => nil
    }

    FEED_OPTIONS = {
      "v" => 2,
      "max-results" => 5,
      "format" => 5
    }

    FEED_URLS = {
      :user_uploads => "http://gdata.youtube.com/feeds/api/users/%s/uploads?%s"
    }

    def self.user_uploads(user, options = {})
      options = FEED_OPTIONS.merge(options)
      feed = open(format(FEED_URLS[:user_uploads], user, options.to_param), OPEN_URI_OPTIONS).read
      YouTube::Parser.parse(feed)
    end

  end

  class Video
    attr_accessor :id, :title, :author, :description, :link, :thumbnail
    attr_accessor :published, :updated, :uploaded, :rating, :keywords, :duration

    def embed(options = {})
      options[:width] ||= 480
      options[:height] ||= 295
      options[:hl] ||= 'de'
      return <<-HTML
<object width="#{options[:width]}" height="#{options[:height]}">
  <param name="movie" value="http://www.youtube.com/v/#{id}&hl=#{options[:hl]}&fs=1&rel=0"></param>
  <param name="allowFullScreen" value="true"></param>
  <param name="allowscriptaccess" value="always"></param>
  <embed src="http://www.youtube.com/v/#{id}&hl=#{options[:hl]}&fs=1&rel=0" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="#{options[:width]}" height="#{options[:height]}">
  </embed>
</object>
HTML
    end
  end

  class Parser

    def self.parse(feed)
      res = []
      doc = Hpricot(feed)
      (doc/"entry").each do |entry|
        res << parse_entry(entry)
      end
      return res
    end

    def self.parse_entry(entry)
      video = Video.new
      video.id = entry.at("media:group yt:videoid").inner_html
      video.title = entry.at("title").inner_html
      video.published = DateTime.strptime(entry.at("published").inner_html, "%Y-%m-%dT%H:%M:%S.000Z")
      video.updated = DateTime.strptime(entry.at("updated").inner_html, "%Y-%m-%dT%H:%M:%S.000Z")
      video.uploaded = DateTime.strptime(entry.at("media:group yt:uploaded").inner_html, "%Y-%m-%dT%H:%M:%S.000Z")
      video.author = entry.at("author name").inner_html
      video.description = entry.at("media:group media:description").inner_html
      video.link = entry.at("media:group media:player").attributes['url']
      video.thumbnail = entry.at("media:group media:thumbnail").attributes['url']
      video.rating =  entry.at("gd:rating").attributes
      video.keywords = entry.at("media:group media:keywords").inner_html.split(',')
      video.duration = entry.at("media:group yt:duration").attributes['seconds'].to_i
      return video
    end

  end
end