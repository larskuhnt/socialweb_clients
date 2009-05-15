Dir.glob(File.join(File.dirname(__FILE__), 'flickr', '*.rb')).each do |file|
  require file
end