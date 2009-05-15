module YouTube

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

end