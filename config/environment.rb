#This file simply gathers all dependencies (gems/DBs/etc)

require 'bundler' #Allows app to know to use bundler to install gems
Bundler.require

module Concerns
end

require_all 'lib'
