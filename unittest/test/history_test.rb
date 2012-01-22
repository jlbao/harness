##
# Test cases for the History class.
#
# @author gpollice@cs.wpi.edu
# @version 22-Jan-2012
#
require 'test/unit'
require_relative "../../lib/history"

class HistoryTest < Test::Unit::TestCase 
  def teardown 
    hd = "../harness"
    `rm -rf #{hd}/*`
    dirs = ["results", "results/failed", "results/passed", "results/unclassified",
      "test", "test/failed", "test/inactive", "test/new", "test/passed", "test/unclassified",
      "history"]
    dirs.each {|d| Dir.mkdir "#{hd}/#{d}"}
  end
  
  def test_start_new_history
    history = History.start_new_history('../harness')
    assert_not_nil(history)
    assert_equal(1, history.index)
  end
  
  def test_log_message
    history = History.new('../harness')
    history.log("Test message")
    lines = history.read_last 1
    assert_equal(1, lines.length)
    assert_equal("Test message", lines[0].rstrip)
  end
end

