#!/usr/bin/env ruby


if !File.exist?("data/tag") then
	tag_file = File.new("data/tag", 'w')
end

ARGV.each do |t|
	case t
		when "-add"
			tag_name = ARGV[1]
			tests = Array.new
			ARGV[2..ARGV.length].each do |arg|
				tests << arg
			end
		else
	end
end