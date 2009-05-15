module Flickr

  class PhotoSet
    attr_accessor :id, :photos, :videos, :title, :description
    attr_accessor :server, :farm, :secret, :primary, :user_id

    def initialize(user_id)
      self.user_id = user_id
    end

    def image_url(type = :small)
      t = case type
        when :thumbnail then "t"
        when :small then "s"
        when :medium then "m"
        when :large then "b"
        when :original then "o"
        else "s"
      end
      return "http://farm#{farm}.static.flickr.com/#{server}/#{primary}_#{secret}_#{t}.jpg"
    end

    def url
      "http://www.flickr.com/photos/#{user_id}/sets/#{id}"
    end

  end
  
end