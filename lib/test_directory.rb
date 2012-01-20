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
    @test_path = harness_path
  end
  
  #
  # Open the directory.
  #
  def open
    @test_directory |= Dir.open("#{@test_path}/test")
  end
end