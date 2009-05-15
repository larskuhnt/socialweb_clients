Dir.glob(File.join(File.dirname(__FILE__), 'youtube', '*.rb')).each do |file|
  require file
end