module Flickr

  class Parser

    def self.parse_photosets(feed, user_id)
      res = []
      doc = Hpricot(feed)
      (doc/"photoset").each do |set|
        res << parse_photoset(set, user_id)
      end
      return res
    end

    def self.parse_photoset(elem, user_id)
      set = PhotoSet.new(user_id)
      set.id = elem.attributes['id']
      set.photos = elem.attributes['photos']
      set.videos = elem.attributes['videos']
      set.primary = elem.attributes['primary']
      set.farm = elem.attributes['farm']
      set.secret = elem.attributes['secret']
      set.server = elem.attributes['server']
      set.description = elem.at('description').inner_html
      set.title = elem.at('title').inner_html
      return set
    end
    
  end

end