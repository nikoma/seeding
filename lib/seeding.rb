require 'rubygems'
require 'uuid'

module Seeding
 
end

directory = File.expand_path(File.dirname(__FILE__))
require File.join(directory, 'seeding', 'create_seed')
