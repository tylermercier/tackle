require 'test/unit'

ENV['RACK_ENV'] = 'test'

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each do |file|
  require File.basename(file, File.extname(file))
end
