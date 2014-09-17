##
# This class encapsulates the loading and saving methods for tags
# @author jbao2@wpi.edu
# @version 12-Sept-2014
##

require 'fileutils'

class Tag
	def self.tag_status
		tag_file = File.open("data/tag", "r+")
		lines = tag_file.readlines
		status = {}
		status = eval(lines[0]) if lines.length > 0
		tag_file.close
		return status
	end

	def self.update_tag status
		tag_file = File.open("data/tag", "w+")
		tag_file.puts status
		tag_file.close
	end
end