##Article Finder App###

##Launch this file from the command line to start the application and get started###

APP_ROOT = File.dirname(__FILE__)

#require "#{APP_ROOT}/lib/guide"
#require File.join(APP_ROOT, 'lib', 'guide.rb')
#require File.join(APP_ROOT, 'lib', 'guide')

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'search'

search = Search.new
search.start_app


