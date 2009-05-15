module YouTube

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
      video.published = Time.zone.parse(entry.at("published").inner_html)
      video.updated = Time.zone.parse(entry.at("updated").inner_html)
      video.uploaded = Time.zone.parse(entry.at("media:group yt:uploaded").inner_html)
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