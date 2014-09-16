#!/usr/bin/env ruby
# Report on the last execution of the test harness 
# (e.g., how many tests passed, how many failed, how many are unclassified, etc.).
#
# Usage: tag -add [tag name] [test name ...]
#
# Author: jbao2@wpi.edu
# Version: 16-Sep-2014


require 'fileutils'
require_relative 'lib/test_directory.rb'
require_relative 'lib/history'
require_relative 'lib/report.rb'
require_relative 'lib/tag.rb'

test_list = []
case ARGV[0]
	when "-add"
	    status = Tag.tag_status
		tag_name = ARGV[1]
		ARGV[2..ARGV.length].each do |arg|
			test_list << arg
			status[arg] = tag_name
		end
		Tag.update_tag status
	else
end

status = Report.test_results
status[:command] = File.basename(__FILE__)
status[:time] = "#{Time.now}"
status[:tests] = test_list

h = History.new
h.log(status)