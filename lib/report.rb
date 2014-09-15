
require_relative 'test_directory.rb'
require_relative 'history.rb'

class Report

	def self.test_results
		dirs = ['unclassified', 'passed', 'failed']
		Dir.chdir("results")
		results = {}
		dirs.each do |dir|
			Dir.chdir(dir)
			new_dir = TestDirectory.new
			count = new_dir.testfile_number
			case dir
				when 'unclassified'
					results[:unclassified] = count
				when 'passed'
					results[:passed] = count
				when 'failed'
					results[:failed] = count
			end
			Dir.chdir("../")
		end
		Dir.chdir("../")
		results
	end

end