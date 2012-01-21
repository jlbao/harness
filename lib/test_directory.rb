##
# This class encapsulates things we can do on the test harness's "test"
# directory.
#
# Author: gpollice@cs.wpi.edu
# Version: 20-Jan-2012
##

class TestDirectory
  #
  # Constructor takes the harness directory path. By default, it
  #
  def initialize harness_path = '.'
    @test_path = "#{harness_path}/test"
  end
  
  #
  # return the files in this directory.
  #
  def files
    entries = []
    Dir.entries(@test_path).each do |e|
      puts e
      entries.push e if File.file? "#{@test_path}/#{e}"
    end
    entries
  end
  
  #
  # return the suubdirectories
  #
  def subdirectories
    entries = []
    Dir.entries(@test_path).each do |e|
      entries.push e if File.directory? "#{@test_path}/#{e}"
    end
    entries - [".", ".."]
  end
end