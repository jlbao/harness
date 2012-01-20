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
  end
  
  def teardown
    hd = "../harness"
    `rm -rf #{hd}/*`
    dirs = ["results", "results/failed", "results/passed", "results/unclassified",
      "test", "test/faled", "test/inactive", "test/new", "test/passed", "test/unclassified"]
    dirs.each {|d| Dir.mkdir "#{hd}/#{d}"}
  end
  
  #
  # 1. Test creating the TestDirectory object.
  #
  def test_constructor
    td = TestDirectory.new "../harness"
    assert_not_nil td
  end
  
  #
  # 2. Test opening the directory.
  #
  def test_open_directory
    td = TestDirectory.new "../harness"
    td.open
    assert(true)
  end
  
  #
  # 3. Make sure that there are no entries
  #
  def test_empty_directory_has_no_entries
    
  end
end