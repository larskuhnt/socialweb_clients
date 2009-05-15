Dir.glob(File.join(File.dirname(__FILE__), 'twitter', '*.rb')).each do |file|
  require file
end