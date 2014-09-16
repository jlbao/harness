#!/usr/bin/env ruby
require 'fileutils'

tag_file = File.open("data/tag", "w+")    
ARGV.each do |t|
	case t
		when "-add"
		    lines = tag_file.readlines
		    status = {}
		    status << eval(lines[0]) if lines.length > 0
			tag_name = ARGV[1]
			ARGV[2..ARGV.length].each do |arg|
				status[arg] = tag_name
			end
			tag_file.puts status
		else
	end
end
tag_file.close