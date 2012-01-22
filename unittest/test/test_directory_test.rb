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
    @td = TestDirectory.new "../harness/test"
  end
  
  def teardown 
    hd = "../harness"
    `rm -rf #{hd}/*`
    dirs = ["results", "results/failed", "results/passed", "results/unclassified",
      "test", "test/failed", "test/inactive", "test/new", "test/passed", "test/unclassified",
      "history"]
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
  
  #
  # 4. Verify that the correct set of files are returned for
  #    the directory.
  def test_files
    `touch ../harness/test/foo ../harness/test/bar`
    f = @td.files
    assert_equal(2, f.length)
    assert(f.find "foo")
    assert(f.find "bar")
  end
  
  #
  # 5. Test moving a file from one subdirectory (path) to
  #    another subdirectory (path).
  def test_move_file_in_subdirectory
    `touch ../harness/test/new/foo`
    nd = TestDirectory.new "../harness/test/new"
    assert(nd.files.find "foo")
    @td.move(:foo, :new, :unclassified)
    assert(File.exist?("../harness/test/unclassified/foo"))
    assert(!File.exist?("../harness/test/new/foo"))
  end
  
  #
  # 6. Test to ensure that the permissions on a moved file
  #    are the same as they were before the move.
  #
  def test_moved_file_permissions
    `touch ../harness/test/new/foo;chmod 754 ../harness/test/new/foo`
    permissions = File.stat("../harness/test/new/foo").mode
    nd = TestDirectory.new "../harness/test/new"
    @td.move(:foo, :new, :unclassified)
    p1 = File.stat("../harness/test/unclassified/foo").mode
    assert_equal(permissions, p1)
  end
end