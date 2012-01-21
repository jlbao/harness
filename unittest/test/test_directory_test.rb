##
# Test cases for the TestDirectory class.
#
# Author: gpollice@cs.wpi.edu
# Version: 20-Jan-2012
##
require 'test/unit'
require_relative '../../lib/test_directory.rb'

class TestDirectoryTest < Test::Unit::TestCase
  def setup
    @td = TestDirectory.new "../harness"
  end
  
  def teardown
    
    hd = "../harness"
    `rm -rf #{hd}/*`
    dirs = ["results", "results/failed", "results/passed", "results/unclassified",
      "test", "test/failed", "test/inactive", "test/new", "test/passed", "test/unclassified"]
    dirs.each {|d| Dir.mkdir "#{hd}/#{d}"}
  end
  
  #
  # 1. Test creating the TestDirectory object.
  #
  def test_constructor
    assert_not_nil @td
  end
  
  #
  # 2. Make sure that there are no files in the test directory
  #
  def test_directory_has_no_files
    assert_equal([], @td.files)
  end
  
  #
  # 3. Verify that there are the expected five diretories below the
  #    test directory.
  def test_subdirectories
    sd = @td.subdirectories
    assert_equal(5, sd.length)
    assert(sd.find "failed")
    assert(sd.find "inactive")
    assert(sd.find "new")
    assert(sd.find "passed")
    assert(sd.find "unclassified")
  end
end